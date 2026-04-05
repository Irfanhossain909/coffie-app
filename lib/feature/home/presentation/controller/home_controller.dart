import 'package:coffie/core/service/api_service/get_storage_services.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/home/domain/model/slider_model.dart';
import 'package:coffie/feature/home/domain/repository/home_repository.dart';
import 'package:coffie/feature/navigation/presentation/controller/navigation_screen_controller.dart';
import 'package:coffie/feature/profile/presentation/controller/profile_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  /// repository here
  final HomeRepository _homeRepository = HomeRepository.instance;
  NavigationScreenController navigationScreenController = Get.find<NavigationScreenController>();

  //GetStorageServices
  GetStorageServices getStorageServices = GetStorageServices.instance;
  bool get isGuest => getStorageServices.getIsGuest();
  String getName() => getStorageServices.getName();

  /// isLoading here
  RxBool isLoading = false.obs;

  /// home slider here
  RxList<SliderDataModel> homeSliderList = <SliderDataModel>[].obs;

  /// init state here
  @override
  void onInit() {
    super.onInit();
    getHomeSlider();
  }

  /// get home slider here
  void getHomeSlider() async {
    try {
      isLoading.value = true;
      final result = await _homeRepository.getHomeSlider();
      homeSliderList.value = result;
    } catch (e) {
      AppLogger.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
