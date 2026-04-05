import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/route/app_routes_file.dart';
import 'package:coffie/core/route/bindings/app_binding.dart';
import 'package:coffie/core/service/api_service/get_storage_services.dart';
import 'package:coffie/core/theme/app_theme.dart';
import 'package:coffie/core/utils/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// ✅ Route Decide Function
  String _getInitialRoute() {
    final token = GetStorageServices.instance.getToken();
    final isGuest = GetStorageServices.instance.getIsGuest();
    if (token.isNotEmpty || isGuest) {
      return AppRoutes.instance.navigationScreen;
    } else {
      return AppRoutes.instance.loginScreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        initialBinding: AppBinding(),
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Coffecito',
        theme: AppTheme.lightTheme,
        getPages: appRootRoutesFile,

        /// ✅ Dynamic Route
        initialRoute: _getInitialRoute(),
      ),
    );
  }
}

// import 'package:coffie/core/route/app_routes.dart';
// import 'package:coffie/core/route/app_routes_file.dart';
// import 'package:coffie/core/theme/app_theme.dart';
// import 'package:coffie/core/utils/app_snackbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(393, 852),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       child: GetMaterialApp(
//         navigatorKey: navigatorKey,
//         debugShowCheckedModeBanner: false,
//         title: 'Coffecito',
//         theme: AppTheme.lightTheme,
//         getPages: appRootRoutesFile,
//         initialRoute: AppRoutes.instance.onBoardingScreen,
//         // initialRoute: AppRoutes.instance.personalInfoScreen,
//       ),
//     );
//   }
// }
