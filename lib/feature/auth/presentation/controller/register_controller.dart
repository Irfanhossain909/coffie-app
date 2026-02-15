import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/auth/domain/repository/register_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  /// repository here
  final RegisterRepository _registerRepository = RegisterRepository.instance;
  // email and password Controller here
  TextEditingController nameController = TextEditingController(
    text: kDebugMode ? 'John Doe' : '',
  );
  TextEditingController emailController = TextEditingController(
    text: kDebugMode ? 'hello123' : "",
  );
  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? 'hello123' : '',
  );
  TextEditingController confirmPasswordController = TextEditingController(
    text: kDebugMode ? 'hello123' : "",
  );

  /// isLoading here
  RxBool isLoading = false.obs;

  // / login function here
  void register() async {
    try {
      isLoading.value = true;
      final result = await _registerRepository.register(
        nameController.text,
        emailController.text,
        passwordController.text,
        confirmPasswordController.text,
      );

      if (result) {
        AppLogger.warning('Register successful');
        AppSnackBar.success('Register successful');
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
