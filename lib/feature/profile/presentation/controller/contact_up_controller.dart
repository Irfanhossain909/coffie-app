import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/profile/domain/repository/setting_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsController extends GetxController {
  // ------------------------------- Repository -------------------------------
  final SettingRepository settingRepository = SettingRepository.instance;
  // ------------------------------- Text Editing Controller -------------------------------
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  // ------------------------------- Rx Variables -------------------------------
  RxBool isLoading = false.obs;
  // ------------------------------- Functions -------------------------------
  void contactUs() async {
    try {
      isLoading.value = true;
      final response = await settingRepository.contactUs(
        nameController.text,
        emailController.text,
        subjectController.text,
        messageController.text,
      );
      if (response) {
        AppLogger.success('Contact Us successful');
        AppSnackBar.success('Contact Us successful');
        Get.back();
      } else {
        AppLogger.error('Contact Us failed');
        AppSnackBar.error('Contact Us failed');
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
