import 'package:coffie/core/service/api_service/get_storage_services.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/home/domain/model/last_order_model.dart';
import 'package:coffie/feature/home/domain/model/slider_model.dart';
import 'package:coffie/feature/home/domain/repository/home_repository.dart';
import 'package:coffie/feature/navigation/presentation/controller/navigation_screen_controller.dart';
import 'package:coffie/feature/profile/domain/repository/profile_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  /// repository here
  final HomeRepository _homeRepository = HomeRepository.instance;
  NavigationScreenController navigationScreenController =
      Get.find<NavigationScreenController>();

  //GetStorageServices
  GetStorageServices getStorageServices = GetStorageServices.instance;
  bool get isGuest => getStorageServices.getIsGuest();
  RxString name = "".obs;

  /// Sync greeting from storage (e.g. after [ProfileRepository.getProfile] calls [GetStorageServices.setName]).
  void refreshNameFromStorage() {
    if (isGuest) return;
    name.value = getStorageServices.getName();
  }

  /// Profile API saves name via [GetStorageServices.setName]; storage may be empty until then.
  Future<void> loadUserName() async {
    if (isGuest) return;

    refreshNameFromStorage();
    if (name.value.isNotEmpty) return;

    isNameLoading.value = true;
    try {
      await ProfileRepository.instance.getProfile();
      refreshNameFromStorage();
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isNameLoading.value = false;
    }
  }

  /// Greeting row — separate from slider loading so one does not clear the other.
  RxBool isNameLoading = false.obs;
  RxBool isSliderLoading = false.obs;

  /// home slider here
  RxList<SliderDataModel> homeSliderList = <SliderDataModel>[].obs;
  Rxn<LastOrderModel> lastOrder = Rxn<LastOrderModel>();

  /// init state here
  @override
  void onInit() {
    super.onInit();
    if (!isGuest) {
      loadUserName();
      getLastOrder();
    }
    getHomeSlider();
  }

  /// get home slider here
  void getHomeSlider() async {
    try {
      isSliderLoading.value = true;
      final result = await _homeRepository.getHomeSlider();
      homeSliderList.value = result;
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isSliderLoading.value = false;
    }
  }

  Future<void> getLastOrder() async {
    try {
      isSliderLoading.value = true;
      final result = await _homeRepository.getLastOrder();
      lastOrder.value = result;
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isSliderLoading.value = false;
    }
  }
}
