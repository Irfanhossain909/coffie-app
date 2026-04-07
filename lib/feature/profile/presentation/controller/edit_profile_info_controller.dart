import 'dart:io';

import 'package:coffie/core/service/location_service/location_service.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/profile/domain/repository/profile_repository.dart';
import 'package:coffie/feature/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditProfileInfoController extends GetxController {
  // ------------------------------- Repository -------------------------------
  final ProfileRepository profileRepository = ProfileRepository.instance;
  LocationService getLocation = LocationService.instance;

  /// profile controller here
  final ProfileController profileController = Get.find<ProfileController>();

  /// name controller here
  TextEditingController nameController = TextEditingController();

  /// phone controller here
  TextEditingController phoneController = TextEditingController();

  /// email controller here
  TextEditingController emailController = TextEditingController();

  /// address controller here
  TextEditingController searchController = TextEditingController();

  /// isLoading here
  RxBool isLoading = false.obs;
  var selectedPlaceId = ''.obs;
  var selectedAddress = ''.obs;
  RxDouble selectedLatitude = 0.0.obs;
  RxDouble selectedLongitude = 0.0.obs;
  var isCurrentLocation = false.obs;

  @override
  void onInit() {
    super.onInit();
    valueInitialize();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    searchController.dispose();
  }

  void valueInitialize() {
    nameController.text =
        profileController.profileModel.value?.data?.name ?? '';
    emailController.text =
        profileController.profileModel.value?.data?.email ?? '';
    phoneController.text =
        profileController.profileModel.value?.data?.phone ?? '';
    searchController.text =
        profileController.profileModel.value?.data?.address ?? '';
    selectedLatitude.value =
        profileController.profileModel.value?.data?.location?.latitude ?? 0.0;
    selectedLongitude.value =
        profileController.profileModel.value?.data?.location?.longitude ?? 0.0;
  }

  Future<void> updateProfileInfo(BuildContext context) async {
    try {
      isLoading.value = true;
      var response = await profileRepository.updateUserProfile(
        name: nameController.text,
        images: cameraImage.value,
        latitude: selectedLatitude.value,
        longitude: selectedLongitude.value,
        address: searchController.text,
      );
      if (response) {
        AppLogger.success("Profile updated successfully");
        AppSnackBar.success("Profile updated successfully");
        await profileController.getProfile();
        Get.back();
      } else {
        AppLogger.error("Failed to update profile");
        AppSnackBar.error("Failed to update profile");
      }
    } catch (e) {
      AppLogger.error(e, title: "EditProfileInfoController");
      AppSnackBar.message(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

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

  ///////////////////////// image ////////////////////////////////////////
  RxString cameraImage = ''.obs;

  void removeImage() {
    cameraImage.value = "";
  }

  Future<void> getImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    // ---------- ANDROID FLOW ----------
    if (Platform.isAndroid) {
      Permission cameraPermission = Permission.camera;

      if (await cameraPermission.isDenied) {
        final result = await cameraPermission.request();

        if (result.isGranted) {
          _showImagePickerDialog(context, picker);
        } else if (result.isDenied) {
          return;
        } else if (result.isPermanentlyDenied) {
          _showSettingsDialog(context);
        }
      } else if (await cameraPermission.isGranted) {
        _showImagePickerDialog(context, picker);
      } else if (await cameraPermission.isPermanentlyDenied) {
        _showSettingsDialog(context);
      }
    }
    // ---------- iOS FLOW ----------
    else {
      // iOS: DO NOT REQUEST PERMISSION HERE
      // Camera open korlei iOS nijer permission popup dekhabe
      _showImagePickerDialog(context, picker);
    }
  }

  void _showImagePickerDialog(BuildContext context, ImagePicker picker) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Choose Option".tr),
        content: Text("Select where you want to pick the image from:".tr),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              // CAMERA
              final XFile? image = await picker.pickImage(
                source: ImageSource.camera,
                imageQuality: 5,
              );

              if (image != null) {
                File file = File(image.path);
                cameraImage.value = file.path;
                AppLogger.info("Image: ${cameraImage.value}");
              }
            },
            child: Text('Camera'.tr),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              // GALLERY
              final XFile? image = await picker.pickImage(
                source: ImageSource.gallery,
                imageQuality: 5,
              );

              if (image != null) {
                File file = File(image.path);
                cameraImage.value = file.path;
                AppLogger.info("Image: ${cameraImage.value}");
              }
            },
            child: Text('Gallery'.tr),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Permission Denied".tr),
        content: Text(
          "Camera permission is required to take a photo. Please enable it from the app settings."
              .tr,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // openAppSettings();
            },
            child: Text('Open Settings'.tr),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'.tr),
          ),
        ],
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////
}
