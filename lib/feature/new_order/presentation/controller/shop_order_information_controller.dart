import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/new_order/domain/model/shop_categoty_model.dart';
import 'package:coffie/feature/new_order/domain/model/store_model.dart';
import 'package:coffie/feature/new_order/domain/model/store_product_model.dart';
import 'package:coffie/feature/new_order/domain/repository/new_order_repository.dart';
import 'package:get/get.dart';

class ShopOrderInformationController extends GetxController {
  /// repository here
  final NewOrderRepository _newOrderRepository = NewOrderRepository.instance;

  /// Observable variables
  RxList<StoreCategoryDataModel> storeCategories =
      <StoreCategoryDataModel>[].obs;
  RxList<StoreProjectDataModel> storeProducts = <StoreProjectDataModel>[].obs;
  RxBool isLoading = false.obs;
  StoreDataModel? store;

  /// init state here
  @override
  void onInit() {
    super.onInit();
    final store = Get.arguments as StoreDataModel;
    this.store = store;
    getStoreCategories();
    getStoreProductById();
  }

  /// get store categories here
  Future<void> getStoreCategories() async {
    try {
      isLoading.value = true;
      final response = await _newOrderRepository.getStoreCategories();
      if (response.isNotEmpty) {
        storeCategories.value = response;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// get store product by id here
  Future<void> getStoreProductById({String? categoryId}) async {
    try {
      isLoading.value = true;
      final response = await _newOrderRepository.getStoreProductById(
        store?.id ?? '',
        categoryId,
      );
      if (response.isNotEmpty) {
        storeProducts.assignAll(response);
      } else {
        storeProducts.clear(); // empty হলে UI clean
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  // final RxString selectedCategory = "".obs;

  void selectCategory(String category) {
    storeCategories.value = storeCategories
        // ignore: unrelated_type_equality_checks
        .where((category) => category.name == category)
        .toList();
  }

  final RxString itemCategory = "".obs;

  void selectItemCategory(String category) {
    itemCategory.value = category;
  }
}
