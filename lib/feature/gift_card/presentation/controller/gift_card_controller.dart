import 'package:get/get.dart';

class GiftCardController extends GetxController {
  final RxString selectedCategory = "".obs;

  void selectCategory(String category) {
    selectedCategory.value = category;
  }
}
