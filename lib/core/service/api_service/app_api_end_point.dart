// ignore_for_file: strict_top_level_inference

import 'package:coffie/core/utils/app_logger.dart';
import 'package:flutter/foundation.dart';

class AppApiEndPoint {
  AppApiEndPoint._privateConstructor();
  static final AppApiEndPoint _instance = AppApiEndPoint._privateConstructor();
  static AppApiEndPoint get instance => _instance;

  //app use base
  static final String domain = _getDomain();
  static final String socketDomain = getSocketUrl();
  final String baseUrl = "$domain/api/v1";
  final String refreshToken = "/auth/refresh-token";

  ////Auth/////////////
  final String googleAuth = "/auth/google";
  final String login = "/auth/login";
  final String signUp = "/users";
  final String verifyEmailOtp = "/auth/verify-email";
  final String verifyPhoneOtp = "/auth/verify-phone";
  final String resendEmailOtp = "/auth/resend-email-otp";
  final String resendPhoneOtp = "/auth/resend-phone-otp";
  final String forgotPassword = "/auth/forget-password";
  final String resetPassword = "/auth/reset-password";
  final String changePassword = "/auth/change-password";
  final String contactUs = "/contuct";
  final String deleteAccount = "/auth/user-delete-account";
  final String updateLocation = "/users/profile";
  ////in app Url/////////////
  final String homeSlider = "/promotions";

  /// Store Orders
  final String stores = "/stores";
  final String storeCategories = "/categories";
  static String storeProductById(var storeId) => "/stores/$storeId/products";
  // static String stores(var latitude, var longitude) =>
  //     "/stores/?latitude=$latitude&longitude=$longitude";

  // Gift card
  final String giftCardBalance = "/giftCards";
  final String giftCardsTransactions = "/giftCards";
  final String giftCardsRedeem = "/giftCardTransactions/redeem";
  final String giftCardsAdd = "/giftCards/add";

  // Reward
  final String rewardPoints = "/users/loyalty-points";
  final String rewardHistory = "/pointTransactions/my-history";
  static String loyeltyCardDetails(var orderId) => "/orders/$orderId";
  static String orderList(var orderType) => "/orders/$orderType";
}

// Move this function outside the class
String _getDomain() {
  String liveServer = "http://10.10.7.58:4001";
  String localServer = "http://10.10.7.58:4001";
  try {
    if (kDebugMode) {
      return localServer;
    }
    return liveServer;
  } catch (e) {
    AppLogger.error(e.toString());
    return liveServer;
  }
  // return liveServer;
}

String getSocketUrl() {
  String liveSocket = "http://10.10.7.58:4001";
  String localSocket = "http://10.10.7.58:4001";
  try {
    if (kDebugMode) {
      return localSocket;
    }
    return liveSocket;
  } catch (e) {
    AppLogger.error(e.toString());
    return liveSocket;
  }
}
