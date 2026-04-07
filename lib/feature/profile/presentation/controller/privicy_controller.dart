import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/profile/domain/repository/setting_repository.dart';
import 'package:get/get.dart';

class PrivicyPolicyController extends GetxController {
  //------------------------- repository -------------------------
  final SettingRepository _settingRepository = SettingRepository.instance;
  String? title;
  RxString content = "".obs;
  String? endPoint;
  RxBool isLoading = false.obs;

  //------------------------- init state -------------------------
  @override
  void onInit() {
    super.onInit();
    title = Get.arguments["title"];
    endPoint = Get.arguments["endPoint"];
    getPrivacyPolicy();
  }

  //------------------------- functions -------------------------
  Future<void> getPrivacyPolicy() async {
    try {
      isLoading.value = true;
      final result = await _settingRepository.getPrivacyPolicy(endPoint ?? "");
      if (result != null) {
        content.value = result;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //----------------------------------------------------------------
}
