import 'package:coffie/core/component/app_webview/stripe_web_view_page.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:coffie/feature/gift_card/presentation/widget/app_success_dialog.dart';
import 'package:coffie/feature/wallet/domain/repository/wallet_repository.dart';
import 'package:coffie/feature/wallet/presentation/controller/my_wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletAddController extends GetxController {
  // repository here
  final WalletRepository walletRepository = WalletRepository.instance;

  // controller here
  final MyWalletController myWalletController = Get.find<MyWalletController>();

  // text editing controller here
  TextEditingController amountController = TextEditingController();

  // isLoading here
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    amountController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }

  // add wallet money function here
  void addWalletMoney() async {
    try {
      isLoading.value = true;
      if (amountController.text.isEmpty) {
        AppSnackBar.error('Please enter amount');
        return;
      }
      final result = await walletRepository.addWalletMoney(
        amount: int.parse(amountController.text),
      );
      if (result != null && result is String) {
        myWalletController.walletBalanceModel.value?.data?.balance =
            (myWalletController.walletBalanceModel.value?.data?.balance ?? 0) +
            int.parse(amountController.text);
        myWalletController.walletBalanceModel.refresh();
        await myWalletController.refreshActiveTabWalletList();
        amountController.clear();
        openStripePayment(
          context: Get.context!,
          paymentUrl: result,
          successUrl: "/wallet/success",
          cancelUrl: "/wallet/cancel",
        );
      } else {
        AppSnackBar.error('Failed to add wallet money');
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
          title: "Money Added Successfully!",
          message:
              "Thank you! Your wallet has been updated and is ready to use for your next order.",
          buttonTitle: "View My Wallet",
          onButtonPressed: () => Get.close(1),
        );
      } else {
        AppLogger.info("Payment Cancelled");
      }
    }
  }
}
