import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/home/domain/model/slider_model.dart';
import 'package:coffie/feature/home/domain/repository/home_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  /// repository here
  final HomeRepository _homeRepository = HomeRepository.instance;

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
