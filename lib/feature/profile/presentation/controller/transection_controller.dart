import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/profile/domain/model/transection_history_model.dart';
import 'package:coffie/feature/profile/domain/repository/setting_repository.dart';
import 'package:get/get.dart';

class TransectionController extends GetxController {
  // repository here
  final SettingRepository settingRepository = SettingRepository.instance;

  // model here
  RxList<TtrancestionHistoryDataModel> transectionHistoryList =
      <TtrancestionHistoryDataModel>[].obs;

  // controller here
  RxBool isLoading = false.obs;
  int page = 1;
  int limit = 10;

  @override
  void onInit() {
    super.onInit();
    getTransectionHistory();
  }

  Future<void> getTransectionHistory() async {
    try {
      isLoading.value = true;
      final result = await settingRepository.getTransectionHistory(
        page: page,
        limit: limit,
      );
      if (result.isNotEmpty) {
        transectionHistoryList.assignAll(result);
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
