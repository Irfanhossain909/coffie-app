import 'dart:convert';

class CartSummaryModel {
    bool? success;
    String? message;
    Data? data;

    CartSummaryModel({
        this.success,
        this.message,
        this.data,
    });

    factory CartSummaryModel.fromRawJson(String str) => CartSummaryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CartSummaryModel.fromJson(Map<String, dynamic> json) => CartSummaryModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    double? tipAmount;
    double? redeemLoyaltyPoints;
    double? loyaltyPointDiscount;
    double? totalPayableAmount;
    double? minimumLoyaltyPointsNeededToUse;
    String? id;
    double? totalPrice;

    Data({
        this.tipAmount,
        this.redeemLoyaltyPoints,
        this.loyaltyPointDiscount,
        this.totalPayableAmount,
        this.minimumLoyaltyPointsNeededToUse,
        this.id,
        this.totalPrice,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        tipAmount: json["tipAmount"]?.toDouble(),
        redeemLoyaltyPoints: json["redeemLoyaltyPoints"]?.toDouble(),
        loyaltyPointDiscount: json["loyaltyPointDiscount"]?.toDouble(),
        totalPayableAmount: json["totalPayableAmount"]?.toDouble(),
        minimumLoyaltyPointsNeededToUse: json["minimumLoyaltyPointsNeededToUse"]?.toDouble(),
        id: json["_id"],
        totalPrice: json["totalPrice"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "tipAmount": tipAmount,
        "redeemLoyaltyPoints": redeemLoyaltyPoints,
        "loyaltyPointDiscount": loyaltyPointDiscount,
        "totalPayableAmount": totalPayableAmount,
        "minimumLoyaltyPointsNeededToUse": minimumLoyaltyPointsNeededToUse,
        "_id": id,
        "totalPrice": totalPrice,
    };
}
