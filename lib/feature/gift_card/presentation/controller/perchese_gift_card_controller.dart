import 'package:coffie/core/component/app_webview/stripe_web_view_page.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/gift_card/domain/repository/gift_card_repository.dart';
import 'package:coffie/feature/gift_card/presentation/widget/app_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PercheseGiftCardController extends GetxController {
  // Repository
  final GiftCardRepository giftCardRepository = GiftCardRepository.instance;

  // loading
  RxBool isLoading = false.obs;

  // variables here
  final RxString selectedCategory = "".obs;
  TextEditingController messageController = TextEditingController();
  TextEditingController receiverNameController = TextEditingController();
  TextEditingController receiverEmailController = TextEditingController();
  //================= Init State ==================
  @override
  void onInit() {
    super.onInit();
    messageController = TextEditingController();
    receiverNameController = TextEditingController();
    receiverEmailController = TextEditingController();
  }

  @override
  void onClose() {
    messageController.dispose();
    receiverNameController.dispose();
    receiverEmailController.dispose();
    super.onClose();
  }

  /// ================== Function to select category ==================
  void selectCategory(String category) {
    AppLogger.info(category);
    selectedCategory.value = category;
  }

  Future<void> sendGiftCard() async {
    try {
      isLoading.value = true;
      final response = await giftCardRepository.sendGiftCard(
        amount: int.parse(selectedCategory.value),
        receiverEmail: receiverEmailController.text,
        receiverName: receiverNameController.text,
        message: messageController.text,
      );
      if (response != null) {
        selectedCategory.value = "";
        messageController.clear();
        receiverNameController.clear();
        receiverEmailController.clear();
        openStripePayment(
          context: Get.context!,
          paymentUrl: response,
          successUrl: "/gift-card/success",
          cancelUrl: "/gift-card/cancel",
        );
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> openStripePayment({
    BuildContext? context,
    required String paymentUrl,
    required String successUrl,
    required String cancelUrl,
  }) async {
    if (context == null) return;
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StripeWebViewPage(
          paymentUrl: paymentUrl,
          successEndpoint: successUrl,
          cancelEndpoint: cancelUrl,
        ),
      ),
    );

    if (result != null && context.mounted) {
      if (result['status'] == 'success') {
        AppSuccessDialog.show(
          context: context,
          icon: Icon(
            Icons.check_circle_rounded,
            color: AppColors.green,
            size: 64,
          ),
          title: "Purchase Successfully!",
          message: "Thank you! Your wallet has been updated and is ready to use for your next order.",
          buttonTitle: "View My Gift Card",
          onButtonPressed: () => Get.close(1),
        );
      } else {
        AppLogger.info("Payment Cancelled");
      }
    }
  }
}
