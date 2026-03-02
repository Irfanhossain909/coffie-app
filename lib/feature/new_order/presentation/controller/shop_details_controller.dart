import 'package:get/get.dart';

class ShopDetailsController extends GetxController {
  final RxString selectedCategory = "".obs;

  void selectCategory(String category) {
    selectedCategory.value = category;
  }
  final RxString itemCategory = "".obs;

  void selectItemCategory(String category) {
    itemCategory.value = category;
  }

  final RxInt numberOfSyrupPumps = 0.obs;

  void incrementNumberOfSyrupPumps() {
    numberOfSyrupPumps.value++;
  }

  void decrementNumberOfSyrupPumps() {
    numberOfSyrupPumps.value--;
  }
  final RxInt numberOfCustomization = 0.obs;

  void incrementNumberOfCustomization() {
    numberOfCustomization.value++;
  }

  void decrementNumberOfCustomization() {
    numberOfCustomization.value--;
  }
}
