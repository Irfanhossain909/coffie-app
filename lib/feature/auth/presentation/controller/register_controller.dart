import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/auth/domain/repository/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  /// repository here
  final AuthRepository _authRepository = AuthRepository.instance;
  // email and password Controller here
  TextEditingController nameController = TextEditingController(
    text: kDebugMode ? 'John Doe' : '',
  );
  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? 'yamiy60604@jsncos.com' : "",
  );
  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? 'Hello@123' : '',
  );
  TextEditingController confirmPasswordController = TextEditingController(
    text: kDebugMode ? 'Hello@123' : "",
  );

  

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  /// isLoading here
  RxBool isLoading = false.obs;

  // / login function here
  void register() async {
    try {
      isLoading.value = true;
      final result = await _authRepository.signUp(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      if (result) {
        Get.toNamed(
          AppRoutes.instance.emailOtpVerifyScreen,
          arguments: {"email": emailController.text, "type": "signUp"},
        );
      } else {
        AppSnackBar.error(
          'Invalid name or email or password or confirm password',
        );
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
