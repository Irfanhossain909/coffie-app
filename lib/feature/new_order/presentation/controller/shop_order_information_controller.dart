import 'package:coffie/core/service/api_service/get_storage_services.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/home/domain/model/last_order_model.dart';
import 'package:coffie/feature/home/domain/repository/home_repository.dart';
import 'package:coffie/feature/new_order/domain/model/shop_categoty_model.dart';
import 'package:coffie/feature/new_order/domain/model/store_model.dart';
import 'package:coffie/feature/new_order/domain/model/store_product_model.dart';
import 'package:coffie/feature/new_order/domain/repository/new_order_repository.dart';
import 'package:get/get.dart';

class ShopOrderInformationController extends GetxController {
  /// repository here
  final NewOrderRepository _newOrderRepository = NewOrderRepository.instance;
  final HomeRepository _homeRepository = HomeRepository.instance;

  /// Observable variables
  RxList<StoreCategoryDataModel> storeCategories =
      <StoreCategoryDataModel>[].obs;
  RxList<StoreProjectDataModel> storeProducts = <StoreProjectDataModel>[].obs;
  RxBool isLoading = false.obs;
  StoreDataModel? store;

  GetStorageServices getStorageServices = GetStorageServices.instance;
  bool get isGuest => getStorageServices.getIsGuest();
  Rxn<LastOrderModel> lastOrder = Rxn<LastOrderModel>();
  RxBool isLastOrderLoading = false.obs;

  /// init state here
  @override
  void onInit() {
    super.onInit();
    final store = Get.arguments as StoreDataModel;
    this.store = store;
    if (!isGuest) {
      getLastOrder();
    }
    getStoreCategories();
    getStoreProductById();
  }

  Future<void> getLastOrder() async {
    try {
      isLastOrderLoading.value = true;
      final result = await _homeRepository.getLastOrder();
      lastOrder.value = result;
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLastOrderLoading.value = false;
    }
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

  final RxString itemCategory = "All".obs;

  void selectItemCategory(String category) {
    itemCategory.value = category;
  }
}
