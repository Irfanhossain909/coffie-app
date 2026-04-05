import 'package:coffie/core/service/api_service/app_storage_key.dart';
import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageServices {
  GetStorageServices._privateConstructor();
  static final GetStorageServices _instance =
      GetStorageServices._privateConstructor();
  static GetStorageServices get instance => _instance;

  ////////////// storage initial
  GetStorage box = GetStorage();

  ////////////////  token
  Future<void> setToken(String value) async {
    try {
      await box.write(AppStorageKey.instance.token, value);
      await box.save();
    } catch (e) {
      AppLogger.error(e.toString());
    }
  }

  String getToken() {
    try {
      return box.read(AppStorageKey.instance.token) ?? "";
    } catch (e) {
      AppLogger.error(e.toString());
      return "";
    }
  }

  Future<void> setIsGuest(bool value) async {
    try {
      await box.write(AppStorageKey.instance.isGuest, value);
      await box.save();
    } catch (e) {
      AppLogger.error(e.toString());
    }
  }

  bool getIsGuest() {
    try {
      return box.read(AppStorageKey.instance.isGuest) ?? false;
    } catch (e) {
      AppLogger.error(e.toString());
      return false;
    }
  }

  Future<void> setName(String value) async {
    try {
      await box.write(AppStorageKey.instance.name, value);
      await box.save();
    } catch (e) {
      AppLogger.error(e.toString());
    }
  }

  String getName() {
    try {
      return box.read(AppStorageKey.instance.name) ?? "";
    } catch (e) {
      AppLogger.error(e.toString());
      return "";
    }
  }

  //////////////// UID (_id)
  // Future<void> setUID(String value) async {
  //   try {
  //     await box.write("UID", value);
  //     await box.save();
  //   } catch (e) {
  //     AppLogger.error(e.toString());
  //   }
  // }

  // String getUID() {
  //   try {
  //     return box.read("UID") ?? "";
  //   } catch (e) {
  //     AppLogger.error(e.toString());
  //     return "";
  //   }
  // }

  ///////////////////////  user FCM token
  // Future<void> setFCMtoken(String value) async {
  //   try {
  //     await box.write("fcmToken", value);
  //     await box.save();
  //   } catch (e) {
  //     AppLogger.error(e.toString());
  //   }
  // }

  // String getFCMtoken() {
  //   try {
  //     return box.read("fcmToken") ?? "";
  //   } catch (e) {
  //     AppLogger.error(e.toString());
  //     return "Fcm Token";
  //   }
  // }
  /////////////////////  user role
  Future<void> setUserRole(String value) async {
    try {
      await box.write(AppStorageKey.instance.userRole, value);
      await box.save();
    } catch (e) {
      AppLogger.error(e.toString());
    }
  }

  String getUserRole() {
    try {
      return box.read(AppStorageKey.instance.userRole) ?? "";
    } catch (e) {
      AppLogger.error(e.toString());
      return "User Role";
    }
  }

  Future<void> storageClear() async {
    try {
      // Clear all stored data
      await box.remove(AppStorageKey.instance.token); // Remove token
      await box.remove("fcmToken"); // Remove token
      await box.remove(AppStorageKey.instance.userRole); // Remove user role
      await box.remove(AppStorageKey.instance.isGuest); // Remove is guest
      await box.remove(AppStorageKey.instance.name); // Remove name
      await box.save();

      // Note: Navigation is now handled by the calling controller
    } catch (e) {
      AppLogger.error(e.toString());
    }
  }

  Future<void> completeLogout() async {
    try {
      await storageClear();

      Future.delayed(Duration(seconds: 1), () {
        // 🔁 Clear routes
        Get.offAllNamed(AppRoutes.instance.loginScreen);
      });

      // 🔥 Reset theme to system
      Get.changeThemeMode(ThemeMode.system);
    } catch (e) {
      AppLogger.error(e.toString());
    }
  }
}
