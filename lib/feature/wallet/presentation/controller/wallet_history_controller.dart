import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/wallet/domain/model/wallet_details_model.dart';
import 'package:coffie/feature/wallet/domain/repository/wallet_repository.dart';
import 'package:get/get.dart';

class WalletHistoryController extends GetxController {
  // repository here
  final WalletRepository walletRepository = WalletRepository.instance;

  // model here
  final Rxn<WalletDetailsModel> walletDetailsModel = Rxn<WalletDetailsModel>();

  // controller here
  final RxBool isLoading = false.obs;
  String? walletId;

  @override
  void onInit() {
    super.onInit();
    walletId = Get.arguments;
    if (walletId == null) {
      Get.back();
      return;
    }
    getWalletHistory();
  }

  Future<void> getWalletHistory() async {
    try {
      isLoading.value = true;
      final result = await walletRepository.getWalletHistory(
        walletId: walletId!,
      );
      if (result != null) {
        walletDetailsModel.value = result;
        update();
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
