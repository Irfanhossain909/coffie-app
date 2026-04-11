import 'dart:convert';

class GiftCardBalanceModel {
  bool? success;
  String? message;
  GiftCardBalanceDataModel? data;

  GiftCardBalanceModel({this.success, this.message, this.data});

  factory GiftCardBalanceModel.fromRawJson(String str) =>
      GiftCardBalanceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GiftCardBalanceModel.fromJson(Map<String, dynamic> json) =>
      GiftCardBalanceModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : GiftCardBalanceDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class GiftCardBalanceDataModel {
  int? totalGiftCards;
  double? totalBalance;

  GiftCardBalanceDataModel({this.totalGiftCards, this.totalBalance});

  factory GiftCardBalanceDataModel.fromRawJson(String str) =>
      GiftCardBalanceDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GiftCardBalanceDataModel.fromJson(Map<String, dynamic> json) =>
      GiftCardBalanceDataModel(
        totalGiftCards: json["totalGiftCards"],
        totalBalance: (json["totalBalance"] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
    "totalGiftCards": totalGiftCards,
    "totalBalance": totalBalance,
  };
}
