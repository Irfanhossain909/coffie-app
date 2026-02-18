import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/feature/gift_card/presentation/ui/gift_card_screen.dart';
import 'package:coffie/feature/home/presentation/ui/home_screen.dart';
import 'package:coffie/feature/navigation/presentation/controller/navigation_screen_controller.dart';
import 'package:coffie/feature/order/presentation/ui/order_screen.dart';
import 'package:coffie/feature/profile/presentation/ui/profile_screen.dart';
import 'package:coffie/feature/reward/presentation/ui/reward_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: NavigationScreenController(),
      builder: (controller) {
        return Scaffold(
          body: Obx(
            () => IndexedStack(
              index: controller.selectedIndex.value,
              children: [
                HomeScreen(),
                RewardScreen(),
                OrderScreen(),
                GiftCardScreen(),
                ProfileScreen(),
              ],
            ),
          ),

          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
            child: SafeArea(
              child: Container(
                // margin: const EdgeInsets.all(16),
                padding: EdgeInsets.only(bottom: 10.r, top: 10.r),
                decoration: BoxDecoration(
                  color: AppColors.backgrounColor,
                  borderRadius: BorderRadius.circular(45),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 4, // 👈 blur বন্ধ
                      spreadRadius: 1,
                      offset: const Offset(0, 4), // 👈 নিচে shadow
                    ),
                  ],
                ),

                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(5, (index) {
                      final isSelected =
                          controller.selectedIndex.value == index;
                      final iconPaths = [
                        AppAssets.nav1,
                        AppAssets.nav2,
                        AppAssets.nav3,
                        AppAssets.nav4,
                        AppAssets.nav5,
                      ];

                      return InkWell(
                        onTap: () => controller.changeIndex(index),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: isSelected
                              ? BoxDecoration(
                                  color: AppColors.blue, // Purple circle
                                  shape: BoxShape.circle,
                                )
                              : null,
                          child: SvgPicture.asset(
                            iconPaths[index],
                            width: 22.r,
                            height: 22.r,
                            colorFilter: ColorFilter.mode(
                              isSelected
                                  ? Colors.white
                                  : AppColors.black.withValues(alpha: 0.5),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
