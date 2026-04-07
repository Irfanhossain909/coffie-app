import 'dart:io';

import 'package:coffie/core/service/api_service/api_services.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/service/api_service/get_storage_services.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/profile/domain/model/profile_model.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ProfileRepository {
  ProfileRepository._();
  static final ProfileRepository _instance = ProfileRepository._();
  static ProfileRepository get instance => _instance;

  ApiServices apiServices = ApiServices.instance;

  Future<bool> updateUserProfile({
    String? name,
    String? images,
    double? latitude,
    double? longitude,
    String? address,
  }) async {
    try {
      // -------------------------------
      // MAIN BODY MAP
      // -------------------------------
      final Map<String, dynamic> data = {};

      void addIfValid(String key, dynamic value) {
        if (value != null) {
          if (value is String && value.isEmpty) return;
          data[key] = value;
        }
      }

      // BASIC INFO
      addIfValid("name", name);
      addIfValid("image", images);
      addIfValid("latitude", latitude);
      addIfValid("longitude", longitude);
      addIfValid("address", address);

      // -------------------------------

      // -------------------------------
      // FORM DATA
      // -------------------------------
      final FormData formData = FormData.fromMap(data);

      // -------------------------------
      // IMAGE FILE (Multipart)
      // -------------------------------
      if (images != null && images.isNotEmpty) {
        try {
          final file = File(images);
          if (await file.exists()) {
            final fileName = file.path.split('/').last;
            final mimeType = lookupMimeType(file.path);

            formData.files.add(
              MapEntry(
                "image",
                await MultipartFile.fromFile(
                  file.path,
                  filename: fileName,
                  contentType: MediaType.parse(
                    mimeType ?? "application/octet-stream",
                  ),
                ),
              ),
            );
          }
        } catch (e) {
          AppLogger.error("❌ Image error: $e");
        }
      }

      // -------------------------------
      // API CALL
      // -------------------------------
      final response = await apiServices.apiPatchServices(
        url: AppApiEndPoint.instance.updateLocation,
        body: formData,
      );

      if (response != null) {
        AppLogger.success("✅ Profile updated successfully");
        return true;
      } else {
        AppLogger.error("❌ Profile update failed");
        return false;
      }
    } catch (e) {
      AppLogger.error(e.toString());
      return false;
    }
  }

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
        GetStorageServices.instance.setName(map["data"]["name"] ?? "");
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

  Future<bool> sendEmailSubscription(String email) async {
    try {
      final response = await apiServices.apiPostServices(
        url: AppApiEndPoint.instance.sendEmailSubscription,
        body: {"email": email},
      );
      if (response == null || response is! Map) {
        return false;
      }
      final map = Map<String, dynamic>.from(response);
      if (map["success"] == true) {
        return true;
      }
      return false;
    } catch (e) {
      AppLogger.error(e.toString());
    }

    return false;
  }
}
