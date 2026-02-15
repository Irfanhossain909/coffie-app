import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/auth/domain/repository/login_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  /// repository here
  final LoginRepository _loginRepository = LoginRepository.instance;
  // email and password Controller here
  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? 'test@example.com' : '',
  );
  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? 'hello123' : "",
  );

  /// isLoading here
  RxBool isLoading = false.obs;

  /// login function here
  void login() async {
    try {
      isLoading.value = true;
      final result = await _loginRepository.login(
        emailController.text,
        passwordController.text,
      );

      if (result) {
        AppLogger.warning('Login successful');
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
