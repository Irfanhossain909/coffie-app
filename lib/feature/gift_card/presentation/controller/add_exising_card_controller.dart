import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/gift_card/domain/repository/gift_card_repository.dart';
import 'package:coffie/feature/gift_card/presentation/controller/gift_card_controller.dart';
import 'package:coffie/feature/gift_card/presentation/widget/app_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExisingCardController extends GetxController {
  // Repository
  final GiftCardRepository giftCardRepository = GiftCardRepository.instance;

  GiftCardController giftCardController = Get.find<GiftCardController>();

  // loading
  RxBool isLoading = false.obs;

  // variables here
  TextEditingController giftCardNumberController = TextEditingController();

  Future<void> addExistingGiftCard() async {
    try {
      isLoading.value = true;
      final response = await giftCardRepository.addExistingGiftCard(
        cardNumber: giftCardNumberController.text,
      );
      if (response) {
        giftCardNumberController.clear();
        await giftCardController.getGiftCardTransactions(
          giftCardEndPoint: "available",
        );
        AppSuccessDialog.show(
          context: Get.context!,
          icon: Icon(
            Icons.check_circle_rounded,
            color: AppColors.green,
            size: 64,
          ),
          title: "Gift Card Added",
          message: "Thank you! Your gift card has been added successfully.",
          buttonTitle: "Back to Gift Card",
          onButtonPressed: () => Get.close(1),
        );
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
