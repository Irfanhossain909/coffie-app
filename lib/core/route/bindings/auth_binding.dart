import 'package:coffie/feature/auth/presentation/controller/login_controller.dart';
import 'package:coffie/feature/auth/presentation/controller/register_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => RegisterController());
    // Get.lazyPut(() => SignInController());
    // Get.lazyPut(() => CreateYourPasswordController());
    // Get.lazyPut(() => CreateNewPasswordController());
    // Get.lazyPut(() => VerifyOtpController());
    // Get.lazyPut(() => ForgetPassVerifyOtpController());
    // Get.lazyPut(() => ForgetPasswordController());
    // Get.lazyPut(() => LocationController());
    // Get.lazyPut(() => AuthController());
    // Get.lazyPut(() => WaitingController());
  }
}
