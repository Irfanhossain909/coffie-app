import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/auth/domain/repository/forget_password_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  // --------------------- Repository -----------------------
  ForgetPasswordRepository forgetPasswordRepository =
      ForgetPasswordRepository.instance;

  // --------------------- Controllers -----------------------
  TextEditingController emailController = TextEditingController();

  // --------------------- Variables -----------------------
  final isLoading = false.obs;

  // --------------------- init -----------------------
  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
  }

  // --------------------- dispose -----------------------
  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  // --------------------- Functions -----------------------
  Future<void> forgetPassword() async {
    isLoading.value = true;
    try {
      final result = await forgetPasswordRepository.forgetPassword(
        emailController.text,
      );
      if (result) {
        AppLogger.success("Password reset email sent");
        AppSnackBar.success("Password reset email sent");
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
