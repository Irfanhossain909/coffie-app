import 'package:coffie/core/route/app_routes.dart';
import 'package:coffie/core/route/bindings/auth_binding.dart';
import 'package:coffie/feature/auth/presentation/ui/login_screen.dart';
import 'package:coffie/feature/auth/presentation/ui/register_screen.dart';
import 'package:get/get.dart';

List<GetPage> appRootRoutesFile = <GetPage>[
  //   /////////////////  splash screen start
  // GetPage(
  //   name: AppRoutes.instance.initial,
  //   binding: SplashScreenBinding(),
  //   page: () => const SplashScreen(),
  //   transitionDuration: Duration(milliseconds: 800),
  //   opaque: false,
  // ),
  GetPage(
    name: AppRoutes.instance.loginScreen,
    binding: AuthBinding(),
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.registerScreen,
    binding: AuthBinding(),
    page: () => const RegisterScreen(),
  ),
  
];
