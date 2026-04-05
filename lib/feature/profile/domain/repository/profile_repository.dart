import 'package:coffie/core/service/api_service/api_services.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/service/api_service/get_storage_services.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/profile/domain/model/profile_model.dart';

class ProfileRepository {
  ProfileRepository._();
  static final ProfileRepository _instance = ProfileRepository._();
  static ProfileRepository get instance => _instance;

  ApiServices apiServices = ApiServices.instance;

  Future<ProfileModel?> getProfile() async {
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.updateLocation,
      );
      if (response == null || response is! Map) {
        return null;
      }
      final map = Map<String, dynamic>.from(response);
      if (map["success"] == true) {
        AppLogger.api(map["data"]?.toString() ?? "", title: "Profile Response");
        GetStorageServices.instance.setName(map["data"]["name"] ?? "");
        AppLogger.api(GetStorageServices.instance.getName(), title: "Name");
        // Full API body { success, message, data: { user } } — not only `data`,
        // otherwise ProfileModel.fromJson looks for nested `data` and gets null.
        return ProfileModel.fromJson(map);
      }
      return null;
    } catch (e) {
      AppLogger.error(e.toString());
    }

    return null;
  }
}
