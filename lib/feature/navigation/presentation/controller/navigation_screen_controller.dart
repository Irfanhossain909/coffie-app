import 'package:get/get.dart';

class NavigationScreenController extends GetxController {
  RxInt selectedIndex = RxInt(0);


  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
