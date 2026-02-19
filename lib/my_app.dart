import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/route/app_routes_file.dart';
import 'package:coffie/core/theme/app_theme.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Coffecito',
        theme: AppTheme.lightTheme,
        getPages: appRootRoutesFile,
        // initialRoute: AppRoutes.instance.navigationScreen,
        initialRoute: AppRoutes.instance.favorateScreen,
      ),
    );
  }
}
