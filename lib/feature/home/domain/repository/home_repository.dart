import 'package:coffie/core/service/api_service/api_services.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/home/domain/model/slider_model.dart';

class HomeRepository {
  HomeRepository._();
  static final HomeRepository _instance = HomeRepository._();
  static HomeRepository get instance => _instance;

  Future<List<SliderDataModel>> getHomeSlider() async {
    List<SliderDataModel> sliderData = <SliderDataModel>[];
    try {
      final response = await ApiServices.instance.apiGetServices(
        AppApiEndPoint.instance.homeSlider,
      );
      if (response["success"] == true) {
        for (var slider in response["data"]) {
          sliderData.add(SliderDataModel.fromJson(slider));
        }
      }
    } catch (e) {
      AppLogger.error("Error in getHomeSlider: $e");
    }
    return sliderData;
  }
}
