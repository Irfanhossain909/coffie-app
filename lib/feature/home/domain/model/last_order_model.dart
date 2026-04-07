import 'dart:convert';

class LastOrderModel {
    bool? success;
    String? message;
    Data? data;

    LastOrderModel({
        this.success,
        this.message,
        this.data,
    });

    factory LastOrderModel.fromRawJson(String str) => LastOrderModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LastOrderModel.fromJson(Map<String, dynamic> json) => LastOrderModel(
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
    String? id;
    String? orderId;
    String? productName;
    double? totalAmount;
    String? orderStatus;
    int? readyTime;
    String? previewImage;

    Data({
        this.id,
        this.orderId,
        this.productName,
        this.totalAmount,
        this.orderStatus,
        this.readyTime,
        this.previewImage,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        orderId: json["orderId"],
        productName: json["productName"],
        totalAmount: json["totalAmount"]?.toDouble(),
        orderStatus: json["orderStatus"],
        readyTime: json["readyTime"],
        previewImage: json["previewImage"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "orderId": orderId,
        "productName": productName,
        "totalAmount": totalAmount,
        "orderStatus": orderStatus,
        "readyTime": readyTime,
        "previewImage": previewImage,
    };
}
