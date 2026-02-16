import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/auth/domain/repository/forget_password_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  // ----------------------- Repository ----------------------
  ForgetPasswordRepository forgetPasswordRepository =
      ForgetPasswordRepository.instance;

  // ----------------------- Text Controllers ----------------------
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // ----------------------- Obx Variables ----------------------
  final RxBool isLoading = false.obs;

  // ----------------------- Functions ----------------------
  Future<void> newPassword() async {
    try {
      isLoading.value = true;
      final result = await forgetPasswordRepository.newPassword(
        passwordController.text,
        confirmPasswordController.text,
      );
      if (result) {
        AppLogger.success("Password changed successfully");
        AppSnackBar.success("Password changed successfully");
      }
    } catch (e) {
      AppLogger.error(e.toString());
      AppSnackBar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
