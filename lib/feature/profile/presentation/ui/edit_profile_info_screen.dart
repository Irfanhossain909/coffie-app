import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_image/app_image_circular.dart';
import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/app_location_field/places_suggation.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/feature/profile/presentation/controller/edit_profile_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditProfileInfoScreen extends StatelessWidget {
  const EditProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileInfoController>(
      init: EditProfileInfoController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(text: "Edit Profile Info"),
          body: SingleChildScrollView(
            child: InkWell(
              onTap: () => FocusScope.of(context).unfocus(),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,

              child: Column(
                children: [
                  Obx(() {
                    return Stack(
                      children: [
                        controller.cameraImage.value.isNotEmpty
                            ? AppImageCircular(
                                width: 162.w,
                                height: 162.h,
                                filePath: controller.cameraImage.value,
                              )
                            : AppImageCircular(
                                width: 162.w,
                                height: 162.h,
                                borderColor: const Color(0xFFE5E7EB),
                                url:
                                    "${AppApiEndPoint.domain}${controller.profileController.profileModel.value?.data?.profileImage}",
                              ),

                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () => controller.getImage(context),
                            child: Container(
                              width: 42.w,
                              height: 42.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.black.withValues(alpha: 0.7),
                                ),
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 24.sp,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: AppColors.black.withValues(alpha: 0.1),
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        spacing: 16.h,
                        children: [
                          AppInputWidgetTwo(
                            controller: controller.nameController,
                            isOptional: true,

                            title: "Full Name",
                            titleFontSize: 14.sp,
                            titleColor: AppColors.black,
                            titleFontWeight: FontWeight.bold,
                            hintText: "Enter Your Full Name",
                          ),
                          AppInputWidgetTwo(
                            readOnly: true,
                            isOptional: true,

                            title: "Phone Number",
                            titleFontSize: 14.sp,
                            titleColor: AppColors.black,
                            titleFontWeight: FontWeight.bold,
                            hintText: "Enter Your Number",
                            controller: controller.phoneController,
                          ),
                          AppInputWidgetTwo(
                            readOnly: true,
                            isOptional: true,

                            title: "Email",
                            titleFontSize: 14.sp,
                            titleColor: AppColors.black,
                            titleFontWeight: FontWeight.bold,
                            hintText: "Enter Your Email",
                            controller: controller.emailController,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AppText(
                              data: "Address",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ),
                          Obx(
                            () => PlaceAutocompleteWidget(
                              controller: controller.searchController,
                              hintText: 'Enter location',
                              hintColor: AppColors.black,
                              borderWidth: 0.9,
                              borderRadius: 12,
                              borderColor: AppColors.yellow,
                              textColor: AppColors.black,
                              showCurrentLocation: controller.hasLocationData,
                              currentLocationAddress:
                                  controller.selectedAddress.value.isNotEmpty
                                  ? controller.selectedAddress.value
                                  : null,
                              currentLocationLat:
                                  controller.selectedLatitude.value != 0.0
                                  ? controller.selectedLatitude.value
                                  : null,
                              currentLocationLng:
                                  controller.selectedLongitude.value != 0.0
                                  ? controller.selectedLongitude.value
                                  : null,
                              onPlaceSelected:
                                  (
                                    placeId,
                                    description, {
                                    isCurrentLocation = false,
                                    lat,
                                    lng,
                                  }) {
                                    controller.onPlaceSelected(
                                      placeId,
                                      description,
                                      isCurrentLocation: isCurrentLocation,
                                      lat: lat,
                                      lng: lng,
                                    );
                                  },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Obx(() {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: AppButton(
                  isLoading: controller.isLoading.value,
                  title: "Save",
                  onTap: () {
                    controller.updateProfileInfo(context);
                  },
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
