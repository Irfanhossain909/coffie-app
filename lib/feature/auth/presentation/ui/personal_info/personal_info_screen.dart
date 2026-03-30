import 'package:coffie/core/component/app_button/app_button.dart';
import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/app_location_field/places_suggation.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/feature/auth/presentation/controller/personal_info/personal_info_controller.dart';
import 'package:coffie/feature/auth/presentation/widget/app_branding/branding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalInfoController>(
      init: PersonalInfoController(),
      builder: (controller) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: Padding(
            padding: EdgeInsets.all(17.w),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 20.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.yellow),
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Column(
                        spacing: 4.h,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Branding(),
                          SizedBox(height: 12.h),
                          AppText(
                            data: "Personal Information",
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: AppText(
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              data:
                                  "Help us personalize your Coffecito experience. Used for order updates and support.",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          AppInputWidgetTwo(
                            controller: controller.phoneController,
                            hintText: "Enter Your Phone Number",
                            borderColor: AppColors.yellow,
                          ),
                          SizedBox(height: 8.h),
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

                          SizedBox(height: 8.h),

                          Obx(() {
                            return GestureDetector(
                              onTap: () async {
                                await controller.fetchUserLocation();
                              },
                              child: Container(
                                width: double.infinity,
                                height: 46.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.yellow),
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: controller.isLoading.value
                                    ? const CircularProgressIndicator(
                                        color: AppColors.yellow,
                                        strokeWidth: 2,
                                      )
                                    : AppText(
                                        data: "Use Current Location",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black,
                                      ),
                              ),
                            );
                          }),
                          SizedBox(height: 8.h),
                          AppButton(
                            isAuthButton: true,
                            titleSize: 18.sp,
                            title: "Save and Continue",
                            onTap: () {
                              controller.updateProfileData();
                            },
                            isLoading: controller.isLoadingForUpdate.value,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
