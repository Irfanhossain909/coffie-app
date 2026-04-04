import 'package:coffie/core/service/location_service/location_service.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/new_order/domain/model/store_model.dart';
import 'package:coffie/feature/new_order/domain/repository/new_order_repository.dart';
import 'package:get/get.dart';

class PickupLocationWithGetShopController extends GetxController {
  /// repository here
  final NewOrderRepository _newOrderRepository = NewOrderRepository.instance;
  LocationService getLocation = LocationService.instance;

  /// Observable variables
  RxBool isLoading = false.obs;
  RxString address = ''.obs;
  RxString lat = ''.obs;
  RxString lng = ''.obs;
  RxString error = ''.obs;
  RxList<StoreDataModel> stores = <StoreDataModel>[].obs;
  RxList<List<double>> storeLocationList = <List<double>>[].obs;
  int page = 1;
  int limit = 10;
  // init function
  @override
  void onInit() {
    super.onInit();
    getUserLocation();
  }

  /// Get Location Method
  Future<void> getUserLocation() async {
    try {
      error.value = '';

      await LocationService.instance.requestLocationPermission();

      // Get values from service
      final service = LocationService.instance;

      if (service.latitude != null && service.longitude != null) {
        lat.value = service.latitude!;
        lng.value = service.longitude!;
        address.value = service.userAddress ?? '';
        getStores(
          latitude: double.parse(lat.value),
          longitude: double.parse(lng.value),
        );
      } else {
        error.value = "Location not available";
      }
    } catch (e) {
      error.value = "Failed to get location";
    }
  }

  Future<void> getStores({
    required double latitude,
    required double longitude,
  }) async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await _newOrderRepository.getStores(
        // latitude: double.parse("40.7128"),
        // longitude: double.parse("-74.006"),
        // latitude: double.parse(lat.value),
        // longitude: double.parse(lng.value),
        limit: limit,
        page: page,
      );
      if (response.isNotEmpty) {
        stores.addAll(response);
        for (var store in response) {
          storeLocationList.add([
            store.location?.coordinates?[0] ?? 0.0,
            store.location?.coordinates?[1] ?? 0.0,
          ]);
        }
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //===============================//

  final RxString selectedCategory = "".obs;

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  final RxString itemCategory = "".obs;

  void selectItemCategory(String category) {
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
