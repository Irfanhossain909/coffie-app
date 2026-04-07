import 'dart:io';

import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/profile/domain/model/profile_model.dart';
import 'package:coffie/feature/profile/domain/repository/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  /// repository here
  final ProfileRepository profileRepository = ProfileRepository.instance;

  /// profile model here
  Rxn<ProfileModel> profileModel = Rxn<ProfileModel>();

  /// email subscription controller here
  TextEditingController emailSubscriptionController = TextEditingController();

  /// isLoading here
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailSubscriptionController = TextEditingController();
    getProfile();
  }

  @override
  void onClose() {
    super.onClose();
    emailSubscriptionController.dispose();
  }

  /// get profile function here
  Future<void> getProfile() async {
    try {
      isLoading.value = true;
      final result = await profileRepository.getProfile();
      if (result != null) {
        profileModel.value =
            result; // GetBuilder does not listen to Rx; rebuild after load.
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void sendEmailSubscription() async {
    try {
      if (emailSubscriptionController.text.isEmpty) {
        AppSnackBar.message('Please enter your email');
        return;
      }
      isLoading.value = true;
      final result = await profileRepository.sendEmailSubscription(
        emailSubscriptionController.text,
      );
      if (result) {
        AppLogger.success('Email subscription successful');
        AppSnackBar.success('Email subscription successful');
        emailSubscriptionController.clear();
        Get.back();
      } else {
        AppLogger.error('Email subscription failed');
        AppSnackBar.message('Email already subscribed');
        emailSubscriptionController.clear();
        Get.back();
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

}
