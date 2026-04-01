import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/auth/domain/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  // --------------------- Repository -----------------------
  final AuthRepository _authRepository = AuthRepository.instance;

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
      final result = await _authRepository.forgetPassword(
        email: emailController.text,
      );
      if (result) {
        Get.toNamed(
          AppRoutes.instance.emailOtpVerifyScreen,
          arguments: {
            "email": emailController.text,
            "type": "forget",
          },
        );
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
