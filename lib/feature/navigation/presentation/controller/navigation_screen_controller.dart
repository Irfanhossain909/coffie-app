import 'dart:math';

import 'package:coffie/core/service/api_service/get_storage_services.dart';
import 'package:get/get.dart';

class NavigationScreenController extends GetxController {
  // Storage Services
  GetStorageServices getStorageServices = GetStorageServices.instance;

  bool get isGuest => getStorageServices.getIsGuest();

  RxInt selectedIndex = RxInt(0);

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  RxString guestName = RxString("");
  RxBool geustLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    guestName.value = generateGuestName(isGuest: isGuest) ?? "";
  }

  String? generateGuestName({required bool isGuest}) {
    try {
      geustLoading.value = true;

      if (!isGuest) return null;

      final random = Random();

      List<String> names = [
        "Latte",
        "Mocha",
        "Brew",
        "Bean",
        "Aroma",
        "Blend",
        "Nova",
        "Milo",
        "Theo",
        "Luna",
      ];

      String name = names[random.nextInt(names.length)];

      // ✅ 10–99 range
      int number = 10 + random.nextInt(90); // 10–99

      return "$name $number";
    } catch (e) {
      return null;
    } finally {
      geustLoading.value = false;
    }
  }
}
