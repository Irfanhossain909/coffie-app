import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/component/appbar/custom_appbar.dart';

class GeustNotificationScreen extends StatelessWidget {
  const GeustNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(text: "Notification"),
      body: Center(child: AppText(data: "No notification found")),
    );
  }
}
