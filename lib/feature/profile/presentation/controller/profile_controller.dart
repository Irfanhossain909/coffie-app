import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/profile/domain/model/profile_model.dart';
import 'package:coffie/feature/profile/domain/repository/profile_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  /// repository here
  final ProfileRepository profileRepository = ProfileRepository.instance;

  /// profile model here
  Rxn<ProfileModel> profileModel = Rxn<ProfileModel>();

  /// isLoading here
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  /// get profile function here
  Future<void> getProfile() async {
    try {
      isLoading.value = true;
      final result = await profileRepository.getProfile();
      if (result != null) {
        profileModel.value =
            result; // GetBuilder does not listen to Rx; rebuild after load.
      }
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
