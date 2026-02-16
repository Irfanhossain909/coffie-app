import 'package:get/get.dart';

class NavigationScreenController extends GetxController {
  RxInt selectedIndex = RxInt(0);

  @override
  void onInit() {
    super.onInit();
  }

  changeIndex(int index) {
    selectedIndex.value = index;
  }
}
