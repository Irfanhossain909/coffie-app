import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:coffie/feature/profile/presentation/controller/privicy_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class PrivicyPolicyScreen extends StatelessWidget {
  const PrivicyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrivicyPolicyController>(
      init: PrivicyPolicyController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppbar(text: controller.title ?? "Privicy Policy"),
          body: Obx(() {
            return Padding(
              padding: EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Html(
                  data: controller.content.value,
                  style: {
                    "body": Style(
                      color: AppColors.black,
                      fontSize: FontSize(14),
                    ),
                    "p": Style(color: AppColors.black),
                    "span": Style(color: AppColors.black),
                    "li": Style(color: AppColors.black),
                    "h1": Style(color: AppColors.black),
                    "h2": Style(color: AppColors.black),
                    "h3": Style(color: AppColors.black),
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
