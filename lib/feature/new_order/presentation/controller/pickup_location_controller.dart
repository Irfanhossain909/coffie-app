import 'package:coffie/core/service/api_service/get_storage_services.dart';
import 'package:coffie/core/service/location_service/location_service.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/new_order/domain/model/store_model.dart';
import 'package:coffie/feature/new_order/domain/repository/new_order_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickupLocationWithGetShopController extends GetxController {
  /// repository here
  final NewOrderRepository _newOrderRepository = NewOrderRepository.instance;
  LocationService getLocation = LocationService.instance;
  TextEditingController searchController = TextEditingController();
  GetStorageServices getStorageServices = GetStorageServices.instance;

  bool get isGuest => getStorageServices.getIsGuest();

  /// Observable variables
  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  RxList<StoreDataModel> stores = <StoreDataModel>[].obs;
  RxList<List<double>> storeLocationList = <List<double>>[].obs;
  int page = 1;
  int limit = 10;
  // init function
  @override
  void onInit() {
    super.onInit();
    // getUserLocation();
    getStores();
  }

  RxBool isSearchLoading = false.obs;

  void searchLocation() {
    isSearchLoading.value = true;

    if (selectedLatitude.value != 0.0 && selectedLongitude.value != 0.0) {
      storeLocationList.clear();
      stores.clear();
      page = 1;
      limit = 10;
      getStores(
        latitude: double.parse(selectedLatitude.value.toString()),
        longitude: double.parse(selectedLongitude.value.toString()),
      );
    }
    isSearchLoading.value = false;
  }

  Future<void> getStores({double? latitude, double? longitude}) async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await _newOrderRepository.getStores(
        latitude: latitude,
        longitude: longitude,
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

  Future<void> addFavorite(String id) async {
    try {
      final response = await _newOrderRepository.addFavorite(
        id: id,
        type: "store",
      );
      if (response) {
        stores.firstWhere((element) => element.id == id).isFavorite = true;
        stores.refresh();
      }
    } catch (e) {
      AppLogger.error(e.toString());
    }
  }

  Future<void> removeFavorite(String id) async {
    try {
      final response = await _newOrderRepository.removeFavorite(
        id: id,
        type: "store",
      );
      if (response) {
        stores.firstWhere((element) => element.id == id).isFavorite = false;
        stores.refresh();
      }
    } catch (e) {
      AppLogger.error(e.toString());
    }
  }

  // =============================== LOCATION DATA START ===============================

  var selectedPlaceId = ''.obs;
  var selectedAddress = ''.obs;
  RxDouble selectedLatitude = 0.0.obs;
  RxDouble selectedLongitude = 0.0.obs;
  var isCurrentLocation = false.obs;

  ////////////////////////// LOCATION DATA ////////////////////////////////////////
  Future<void> fetchUserLocation() async {
    isLoading.value = true;
    // Call location permission and fetch location
    await getLocation.requestLocationPermission();

    // Get location data from LocationService
    final address = getLocation.userAddress;
    final lat = getLocation.latitude;
    final lng = getLocation.longitude;

    // If location found successfully, set values
    if (lat != null && lng != null && address != null) {
      selectedLatitude.value = double.parse(lat);
      selectedLongitude.value = double.parse(lng);
      selectedAddress.value = address;
      selectedPlaceId.value = 'current_location';
      isCurrentLocation.value = true;

      // Update search controller to show current location
      searchController.text = address;

      AppLogger.info(
        "User location:\n"
        "Address: $address\n"
        "Latitude: $lat\n"
        "Longitude: $lng",
      );
      AppLogger.info(
        "Data lat  : ${selectedLatitude.value}\nData long  : ${selectedLongitude.value}\n",
      );

      isLoading.value = false;
    } else {
      // Handle case where location not found
      isCurrentLocation.value = false;
      isLoading.value = false;
      AppLogger.error('Failed to fetch user location');
    }
    isLoading.value = false;
  }

  // Handle place selection from PlaceAutocompleteWidget
  void onPlaceSelected(
    String placeId,
    String description, {
    bool isCurrentLocation = false,
    double? lat,
    double? lng,
  }) {
    // Update all location data
    selectedPlaceId.value = placeId;
    selectedAddress.value = description;
    this.isCurrentLocation.value = isCurrentLocation;

    if (lat != null && lng != null) {
      selectedLatitude.value = lat;
      selectedLongitude.value = lng;

      AppLogger.info(
        "Selected place: $description\n"
        "Place ID: $placeId\n"
        "Latitude: $lat\n"
        "Longitude: $lng\n"
        "Is Current Location: $isCurrentLocation",
      );
    } else {
      AppLogger.info(
        "Selected place: $description\n"
        "Place ID: $placeId\n"
        "⚠️ Lat/Lng not available\n"
        "Is Current Location: $isCurrentLocation",
      );
    }
  }

  // Check if current location data is available
  bool get hasLocationData {
    return selectedAddress.value.isNotEmpty &&
        selectedLatitude.value != 0.0 &&
        selectedLongitude.value != 0.0;
  }

  // Clear location data
  void clearLocation() {
    selectedPlaceId.value = '';
    selectedAddress.value = '';
    selectedLatitude.value = 0.0;
    selectedLongitude.value = 0.0;
    isCurrentLocation.value = false;
  }

  // Get location as Map
  Map<String, dynamic> getLocationData() {
    return {
      'place_id': selectedPlaceId.value,
      'address': selectedAddress.value,
      'latitude': selectedLatitude.value,
      'longitude': selectedLongitude.value,
      'is_current_location': isCurrentLocation.value,
    };
  }

  ////////////////////////// LOCATION DATA END ////////////////////////////////////////
}
