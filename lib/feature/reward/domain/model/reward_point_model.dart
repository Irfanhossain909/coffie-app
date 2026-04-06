import 'dart:convert';

class RewardPointModel {
    bool? success;
    String? message;
    Data? data;

    RewardPointModel({
        this.success,
        this.message,
        this.data,
    });

    factory RewardPointModel.fromRawJson(String str) => RewardPointModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RewardPointModel.fromJson(Map<String, dynamic> json) => RewardPointModel(
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
    int? loyaltyPoints;

    Data({
        this.loyaltyPoints,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        loyaltyPoints: json["loyaltyPoints"],
    );

    Map<String, dynamic> toJson() => {
        "loyaltyPoints": loyaltyPoints,
    };
}
