import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/auth/domain/repository/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  /// repository here
  final AuthRepository _authRepository = AuthRepository.instance;
  // email and password Controller here
  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? 'vewegem683@jsncos.com' : '',
  );
  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? 'Test@1234' : "",
  );

  /// isLoading here
  RxBool isLoading = false.obs;

  /// login function here
  void login() async {
    try {
      isLoading.value = true;
      final result = await _authRepository.login(
        email: emailController.text,
        password: passwordController.text,
      );

      if (result) {
        Get.offAllNamed(AppRoutes.instance.navigationScreen);
        AppLogger.success('Login successful');
        AppSnackBar.success('Login successful');
      } else {
        AppSnackBar.error('Invalid email or password');
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
