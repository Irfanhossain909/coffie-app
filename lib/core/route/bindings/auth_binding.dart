import 'package:coffie/feature/auth/presentation/controller/email_otp_verify_controller.dart';
import 'package:coffie/feature/auth/presentation/controller/forget_password/forget_password_controller.dart';
import 'package:coffie/feature/auth/presentation/controller/login_controller.dart';
import 'package:coffie/feature/auth/presentation/controller/personal_info/phone_otp_verify_controller.dart';
import 'package:coffie/feature/auth/presentation/controller/register_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => ForgetPasswordController());
    Get.lazyPut(() => PhoneOtpVerifyController());
    Get.lazyPut(() => EmailOtpVerifyController());
  }
}
