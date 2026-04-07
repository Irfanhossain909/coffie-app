import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/new_order/domain/model/single_product_model.dart';
import 'package:coffie/feature/new_order/domain/repository/new_order_repository.dart';
import 'package:get/get.dart';

class ProductInfoController extends GetxController {
  /// repository here
  final NewOrderRepository _newOrderRepository = NewOrderRepository.instance;

  /// Observable variables
  Rxn<SingleProductModel> singleProduct = Rxn<SingleProductModel>();
  final RxString selectedCategory = "".obs;
  RxList<String> selectedCategories = <String>[].obs;
  RxInt syrupPumps = 0.obs;
  RxBool isLoading = false.obs;
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

  /// get single product here
  Future<void> getSingleProduct() async {
    try {
      isLoading.value = true;
      final result = await _newOrderRepository.getSingleProduct(
        productId ?? '',
      );
      singleProduct.value = result;
    } catch (e) {
      AppLogger.error("Error in getSingleProduct: $e");
    }
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  final RxString itemCategory = "".obs;

  void selectItemCategory(String category) {
    AppLogger.info("Selected Category: $category");
    itemCategory.value = category;
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
