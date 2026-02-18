import 'package:get/get.dart';

class PrivicyPolicyController extends GetxController {
  String? title;

  //------------------------- init state -------------------------
  @override
  void onInit() {
    super.onInit();
    title = Get.arguments["title"];
  }
  //------------------------- functions -------------------------

  //----------------------------------------------------------------
}
