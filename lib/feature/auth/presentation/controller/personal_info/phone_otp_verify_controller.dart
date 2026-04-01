import 'dart:async';

import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/auth/domain/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneOtpVerifyController extends GetxController {
  TextEditingController otpTextEditingController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository.instance;
  RxInt remainingSeconds = 180.obs; // 3 minutes in seconds
  var canResend = false.obs;
  late String phone;
  late String type;
  late Timer _timer;
  RxBool isLoading = false.obs;
  var clearOtpField = false.obs; // To trigger clearing of OTP fields

  Future<void> verifyPhoneOtp() async {
    try {
      isLoading.value = true;
      final response = await _authRepository.phoneVerify(
        phone: phone,
        otp: int.parse(otpTextEditingController.text),
      );
      if (response) {
        Get.offAllNamed(AppRoutes.instance.navigationScreen);
        // AppSnackBar.success("Verification Successful");
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
    phone = Get.arguments["phone"];
  }

  void startTimer() {
    // This will keep the timer going in the background
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        // Timer has completed
        canResend.value = true;
        _timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer.cancel();
    otpTextEditingController.dispose();
    super.onClose();
  }

  void resetTimer() {
    remainingSeconds.value = 180; // Reset the timer back to 180 seconds
    canResend.value = false; // Disable the resend button
    startTimer(); // Restart the timer
  }

  String formatTime() {
    final minutes = remainingSeconds.value ~/ 60;
    final remainingSec = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSec.toString().padLeft(2, '0')}';
  }

  /// Resend the OTP code
  void resendCode() async {
    try {
      // Assume success for now
      final isSuccess = await _authRepository.resendPhoneOtp(phone: phone);
      if (isSuccess) {
        clearOtpFields();
        resetTimer(); // Reset the timer after sending the OTP
      }
    } catch (e) {
      AppSnackBar.error("An error occurred. Please try again.");
    }
  }

  /// Clear OTP fields
  void clearOtpFields() {
    clearOtpField.value = true;
    otpTextEditingController.clear();

    // Reset the flag after a short delay to allow UI to update
    Future.delayed(Duration(milliseconds: 100), () {
      clearOtpField.value = false;
    });
  }
}
