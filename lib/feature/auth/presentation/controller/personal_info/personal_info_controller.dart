import 'package:coffie/core/service/api_service/get_storage_services.dart';
import 'package:coffie/core/service/location_service/location_service.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/auth/domain/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInfoController extends GetxController {
  /// repository here
  final AuthRepository _authRepository = AuthRepository.instance;
  TextEditingController searchController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  LocationService getLocation = LocationService.instance;
  GetStorageServices getStorageServices = GetStorageServices.instance;

  // Reactive variables to store search query
  var searchQuery = ''.obs;
  // Reactive variables to store location data

  var isLoading = false.obs;
  var isLoadingForUpdate = false.obs;
  var selectedPlaceId = ''.obs;
  var selectedAddress = ''.obs;
  RxDouble selectedLatitude = 0.0.obs;
  RxDouble selectedLongitude = 0.0.obs;
  var isCurrentLocation = false.obs;

  // ///Functions GetLocation
  Future<void> updateProfileData() async {
    final token = getStorageServices.getToken();
    if (token.isNotEmpty) {
      AppSnackBar.message("Token is not available");
      return;
    }
    if (selectedLatitude.value == 0.0 && selectedLongitude.value == 0.0) {
      AppSnackBar.message("Please select a location to update your profile");
      return;
    }
    try {
      isLoadingForUpdate.value = true;
      var response = await _authRepository.updateLocation(
        address: selectedAddress.value,
        latitude: selectedLatitude.value,
        longitude: selectedLongitude.value,
        phone: phoneController.text,
        isOnboard: "true",
      );

      if (response != null) {
        AppSnackBar.success("Profile updated successfully");
        // Get.toNamed(AppRoutes.instance.navigationScreen);
      } else {
        AppLogger.error("Failed to update profile data");
        isLoadingForUpdate.value = false;
      }
    } catch (e) {
      AppLogger.error(e, title: "LocationController");
      isLoadingForUpdate.value = false;
    } finally {
      isLoadingForUpdate.value = false;
    }
  }

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
}
