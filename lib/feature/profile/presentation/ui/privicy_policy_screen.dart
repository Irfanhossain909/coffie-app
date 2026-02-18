import 'package:coffie/core/component/appbar/custom_appbar.dart';
import 'package:coffie/feature/profile/presentation/controller/privicy_controller.dart';
import 'package:flutter/material.dart';
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
        );
      },
    );
  }
}
