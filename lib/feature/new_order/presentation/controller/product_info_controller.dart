import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/new_order/domain/entity/add_to_cart_entity.dart';
import 'package:coffie/feature/new_order/domain/model/single_product_model.dart';
import 'package:coffie/feature/new_order/domain/repository/new_order_repository.dart';
import 'package:get/get.dart';

class ProductInfoController extends GetxController {
  /// repository here
  final NewOrderRepository _newOrderRepository = NewOrderRepository.instance;

  /// Observable variables
  Rxn<SingleProductModel> singleProduct = Rxn<SingleProductModel>();
  final RxString selectedCategory = "".obs;

  /// Per customization `_id`: selected option `_id` (type `single`).
  final Map<String, RxString> _singleOptionIdByCustomization = {};

  /// Per customization `_id`: selected option `_id`s (type `multi`).
  final Map<String, RxList<String>> _multiOptionIdsByCustomization = {};

  /// Per customization key and option `_id`: count (type `quantity`, multiple options).
  final Map<String, Map<String, RxInt>> _quantityByCustomizationAndOption = {};

  RxList<SelectedCustomization> addToCartitemList =
      <SelectedCustomization>[].obs;
  RxBool isLoading = false.obs;
  RxBool isAddToCartLoading = false.obs;
  String? productId;

  /// init state here
  @override
  void onInit() {
    super.onInit();
    productId = Get.arguments;
    if (productId == null) {
      Get.back();
    } else {
      getSingleProduct();
    }
  }

  static String _uiKey(Customization c, int index) =>
      c.id ?? 'customization_$index';

  static double _optionPriceById(List<Option> options, String rawId) {
    final id = rawId.trim();
    if (id.isEmpty) {
      return 0;
    }
    for (final o in options) {
      if ((o.id ?? '').trim() == id) {
        return o.price ?? 0;
      }
    }
    return 0;
  }

  /// Base price + live add-ons from current selections (call inside [Obx] to react).
  double get displayTotalPrice {
    final data = singleProduct.value?.data;
    final base = data?.basePrice ?? 0;
    final customs = data?.customizations;
    if (customs == null || customs.isEmpty) {
      return base;
    }

    var add = 0.0;
    for (var i = 0; i < customs.length; i++) {
      final c = customs[i];
      final type = (c.type ?? '').trim().toLowerCase();
      final uiKey = _uiKey(c, i);
      final options = c.options ?? [];

      switch (type) {
        case 'single':
          final oid = singleSelectedOptionIdFor(uiKey).value.trim();
          if (oid.isNotEmpty) {
            add += _optionPriceById(options, oid);
          }
          break;

        case 'multi':
          final list = multiSelectedOptionIdsFor(uiKey);
          for (var j = 0; j < list.length; j++) {
            final id = list[j].trim();
            if (id.isNotEmpty) {
              add += _optionPriceById(options, id);
            }
          }
          break;

        case 'quantity':
          for (final o in options) {
            final oid = o.id?.trim() ?? '';
            if (oid.isEmpty) {
              continue;
            }
            final q = quantityForOption(uiKey, oid).value;
            if (q > 0) {
              add += q * (o.price ?? 0);
            }
          }
          break;

        default:
          break;
      }
    }

    return base + add;
  }

  /// Builds `selectedCustomizations` from current UI state. Returns null if validation fails.
  List<SelectedCustomization>? buildSelectedCustomizationsPayload() {
    final customs = singleProduct.value?.data?.customizations;
    if (customs == null || customs.isEmpty) {
      return <SelectedCustomization>[];
    }

    final out = <SelectedCustomization>[];

    for (var i = 0; i < customs.length; i++) {
      final c = customs[i];
      final type = (c.type ?? '').trim().toLowerCase();
      final uiKey = _uiKey(c, i);
      final cid = c.id;
      final required = c.isRequired ?? false;

      if (cid == null || cid.isEmpty) {
        if (required) {
          AppSnackBar.error(
            "Missing customization id for ${c.name ?? 'an option'}.",
          );
          return null;
        }
        continue;
      }

      switch (type) {
        case 'single':
          final optionId = singleSelectedOptionIdFor(uiKey).value.trim();
          if (required && optionId.isEmpty) {
            AppSnackBar.error("Please select ${c.name ?? 'an option'}.");
            return null;
          }
          if (optionId.isNotEmpty) {
            out.add(
              SelectedCustomization(customizationId: cid, optionId: optionId),
            );
          }
          break;

        case 'multi':
          final raw = multiSelectedOptionIdsFor(uiKey).toList();
          final optionIds = raw
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();
          if (required && optionIds.isEmpty) {
            AppSnackBar.error(
              "Please select at least one for ${c.name ?? 'this option'}.",
            );
            return null;
          }
          if (optionIds.isNotEmpty) {
            out.add(
              SelectedCustomization(customizationId: cid, optionIds: optionIds),
            );
          }
          break;

        case 'quantity':
          final options = c.options ?? [];
          if (options.isEmpty) {
            if (required) {
              AppSnackBar.error(
                "${c.name ?? 'This option'} is not configured.",
              );
              return null;
            }
            break;
          }

          var hasValidOption = false;
          var anyPositive = false;
          for (final o in options) {
            final oid = o.id?.trim() ?? '';
            if (oid.isEmpty) {
              continue;
            }
            hasValidOption = true;
            final qty = quantityForOption(uiKey, oid).value;
            if (qty > 0) {
              anyPositive = true;
              out.add(
                SelectedCustomization(
                  customizationId: cid,
                  optionId: oid,
                  quantity: qty,
                ),
              );
            }
          }

          if (!hasValidOption) {
            if (required) {
              AppSnackBar.error(
                "Invalid option for ${c.name ?? 'this customization'}.",
              );
              return null;
            }
            break;
          }

          if (required && !anyPositive) {
            AppSnackBar.error(
              "Please set quantity for ${c.name ?? 'this option'}.",
            );
            return null;
          }
          break;

        default:
          break;
      }
    }

    return out;
  }

  Future<void> addToCartFromSelections() async {
    final product = singleProduct.value?.data?.id;
    if (product == null || product.isEmpty) {
      AppSnackBar.error("Product is not loaded.");
      return;
    }

    final payload = buildSelectedCustomizationsPayload();
    if (payload == null) {
      return;
    }

    addToCartitemList.assignAll(payload);
    await addToCart(addToCart: payload);
  }

  Future<void> addToCart({
    required List<SelectedCustomization> addToCart,
  }) async {
    try {
      isAddToCartLoading.value = true;
      final response = await _newOrderRepository.addToCart(
        product: singleProduct.value?.data?.id ?? '',
        quantity: 1,
        addToCart: addToCart,
      );
      if (response) {
        resetCustomizationSelectionsAfterAddToCart();
        AppSnackBar.success("Product added to cart successfully");
      } else {
        AppSnackBar.error("Failed to add product to cart");
      }
    } catch (e) {
      AppLogger.error("Error in addToCart: $e");
      AppSnackBar.error("Failed to add product to cart");
    } finally {
      isAddToCartLoading.value = false;
    }
  }

  /// get single product here
  Future<void> getSingleProduct() async {
    try {
      isLoading.value = true;
      final result = await _newOrderRepository.getSingleProduct(
        productId ?? '',
      );
      singleProduct.value = result;
      if (result != null) {
        _clearCustomizationSelections();
      }
    } catch (e) {
      AppLogger.error("Error in getSingleProduct: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void _clearCustomizationSelections() {
    _singleOptionIdByCustomization.clear();
    _multiOptionIdsByCustomization.clear();
    _quantityByCustomizationAndOption.clear();
  }

  /// Clears UI selection state while keeping the same [Rx] instances (for live widgets).
  void resetCustomizationSelectionsAfterAddToCart() {
    for (final r in _singleOptionIdByCustomization.values) {
      r.value = '';
    }
    for (final r in _multiOptionIdsByCustomization.values) {
      r.clear();
    }
    for (final inner in _quantityByCustomizationAndOption.values) {
      for (final r in inner.values) {
        r.value = 0;
      }
    }
    addToCartitemList.clear();
  }

  RxInt quantityForOption(String customizationKey, String optionId) {
    final inner = _quantityByCustomizationAndOption.putIfAbsent(
      customizationKey,
      () => {},
    );
    return inner.putIfAbsent(optionId, () => 0.obs);
  }

  /// Reactive selected option id for one customization (single-select).
  RxString singleSelectedOptionIdFor(String customizationId) {
    return _singleOptionIdByCustomization.putIfAbsent(
      customizationId,
      () => ''.obs,
    );
  }

  /// Reactive selected option ids for one customization (multi-select).
  RxList<String> multiSelectedOptionIdsFor(String customizationId) {
    return _multiOptionIdsByCustomization.putIfAbsent(
      customizationId,
      () => <String>[].obs,
    );
  }

  void selectSingleOption(String customizationId, String optionId) {
    singleSelectedOptionIdFor(customizationId).value = optionId;
    AppLogger.info(
      "Selected optionId: $optionId (customization: $customizationId)",
    );
  }

  final RxInt numberOfSyrupPumps = 0.obs;

  void incrementNumberOfSyrupPumps() {
    numberOfSyrupPumps.value++;
  }

  void decrementNumberOfSyrupPumps() {
    numberOfSyrupPumps.value--;
  }

  final RxInt numberOfCustomization = 0.obs;

  void incrementNumberOfCustomization() {
    numberOfCustomization.value++;
  }

  void decrementNumberOfCustomization() {
    numberOfCustomization.value--;
  }
}
