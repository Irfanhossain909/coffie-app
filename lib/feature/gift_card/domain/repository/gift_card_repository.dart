import 'package:coffie/core/service/api_service/api_services.dart';
import 'package:coffie/core/service/api_service/app_api_end_point.dart';
import 'package:coffie/core/utils/app_logger.dart';
import 'package:coffie/feature/gift_card/domain/model/gift_card_balance_model.dart';
import 'package:coffie/feature/gift_card/domain/model/gift_card_model.dart';
import 'package:coffie/feature/gift_card/domain/model/gift_card_redeem_model.dart';

class GiftCardRepository {
  GiftCardRepository._();
  static final GiftCardRepository _instance = GiftCardRepository._();
  static GiftCardRepository get instance => _instance;

  ApiServices apiServices = ApiServices.instance;

  Future<GiftCardBalanceModel?> getGiftCardBalance() async {
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.giftCardBalance,
      );
      if (response != null && response is Map<String, dynamic>) {
        return GiftCardBalanceModel.fromJson(response);
      }
      return null;
    } catch (e) {
      AppLogger.error(e.toString());
    }

    return null;
  }

  Future<List<GiftCardDataModel>> getGiftCardTransactions({
    required String giftCardEndPoint,
  }) async {
    List<GiftCardDataModel> giftCardTransactions = <GiftCardDataModel>[];
    try {
      final response = await apiServices.apiGetServices(
        "${AppApiEndPoint.instance.giftCardsTransactions}/$giftCardEndPoint",
      );
      if (response != null) {
        if (response["data"] != null && response["data"] is List) {
          for (var transaction in response["data"]) {
            giftCardTransactions.add(GiftCardDataModel.fromJson(transaction));
          }
        }
      }
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return giftCardTransactions;
  }

  Future<List<GiftCardRedemDataModel>> getGiftCardRedeem() async {
    List<GiftCardRedemDataModel> giftCardRedeem = <GiftCardRedemDataModel>[];
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.giftCardsRedeem,
      );
      if (response != null) {
        if (response["data"] != null && response["data"] is List) {
          for (var transaction in response["data"]) {
            giftCardRedeem.add(GiftCardRedemDataModel.fromJson(transaction));
          }
        }
      }
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return giftCardRedeem;
  }

  Future<dynamic> sendGiftCard({
    required int amount,
    required String receiverEmail,
    required String receiverName,
    required String message,
  }) async {
    try {
      final response = await apiServices.apiPostServices(
        url: AppApiEndPoint.instance.giftCardBalance,
        body: {
          "amount": amount,
          "receiverEmail": receiverEmail,
          "receiverName": receiverName,
          "message": message,
        },
      );
      if (response != null && response is Map<String, dynamic>) {
        AppLogger.api(response.toString());
        return response["data"]["checkoutUrl"];
      }
      return false;
    } catch (e) {
      AppLogger.error(e.toString());
    }

    return false;
  }

  Future<bool> addExistingGiftCard({required String cardNumber}) async {
    try {
      final response = await apiServices.apiPostServices(
        url: AppApiEndPoint.instance.giftCardsAdd,
        body: {"cardNumber": cardNumber},
      );
      if (response != null && response is Map<String, dynamic>) {
        return true;
      }
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return false;
  }
}
