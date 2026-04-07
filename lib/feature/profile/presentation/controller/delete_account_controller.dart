import 'package:coffie/core/service/api_service/get_storage_services.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/profile/domain/repository/setting_repository.dart';
import 'package:coffie/feature/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccountController extends GetxController {
  /// repository here
  final SettingRepository _settingRepository = SettingRepository.instance;
  ProfileController profileController = Get.find<ProfileController>();

  /// password Controller here
  TextEditingController passwordController = TextEditingController();

  /// isLoading here
  RxBool isLoading = false.obs;

  /// delete account function here
  void deleteAccount() async {
    try {
      isLoading.value = true;
      final result = await _settingRepository.deleteAccount(
        passwordController.text,
        profileController.profileModel.value?.data?.id ?? "",
      );
      if (result) {
        AppLogger.warning('Delete account successful');
        AppSnackBar.success('Delete account successful');
        GetStorageServices.instance.completeLogout();
      } else {
        AppSnackBar.error('Invalid password');
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
