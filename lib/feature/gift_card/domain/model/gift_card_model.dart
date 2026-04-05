import 'dart:convert';

class GiftCardModel {
    bool? success;
    String? message;
    Pagination? pagination;
    List<GiftCardDataModel>? data;

    GiftCardModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory GiftCardModel.fromRawJson(String str) => GiftCardModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GiftCardModel.fromJson(Map<String, dynamic> json) => GiftCardModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<GiftCardDataModel>.from(json["data"]!.map((x) => GiftCardDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class GiftCardDataModel {
    String? id;
    String? cardNumber;
    int? amount;
    int? currentBalance;
    String? sender;
    String? receiverEmail;
    String? receiverName;
    String? message;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    GiftCardDataModel({
        this.id,
        this.cardNumber,
        this.amount,
        this.currentBalance,
        this.sender,
        this.receiverEmail,
        this.receiverName,
        this.message,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory GiftCardDataModel.fromRawJson(String str) => GiftCardDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GiftCardDataModel.fromJson(Map<String, dynamic> json) => GiftCardDataModel(
        id: json["_id"],
        cardNumber: json["cardNumber"],
        amount: json["amount"],
        currentBalance: json["currentBalance"],
        sender: json["sender"],
        receiverEmail: json["receiverEmail"],
        receiverName: json["receiverName"],
        message: json["message"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "cardNumber": cardNumber,
        "amount": amount,
        "currentBalance": currentBalance,
        "sender": sender,
        "receiverEmail": receiverEmail,
        "receiverName": receiverName,
        "message": message,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Pagination {
    int? total;
    int? limit;
    int? page;
    int? totalPage;

    Pagination({
        this.total,
        this.limit,
        this.page,
        this.totalPage,
    });

    factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        limit: json["limit"],
        page: json["page"],
        totalPage: json["totalPage"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "page": page,
        "totalPage": totalPage,
    };
}
