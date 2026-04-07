import 'dart:convert';

class TtrancestionHistoryModel {
    bool? success;
    String? message;
    Pagination? pagination;
    List<TtrancestionHistoryDataModel>? data;

    TtrancestionHistoryModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory TtrancestionHistoryModel.fromRawJson(String str) => TtrancestionHistoryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TtrancestionHistoryModel.fromJson(Map<String, dynamic> json) => TtrancestionHistoryModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<TtrancestionHistoryDataModel>.from(json["data"]!.map((x) => TtrancestionHistoryDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class TtrancestionHistoryDataModel {
    String? id;
    String? orderId;
    int? tipAmount;
    double? totalAmount;
    String? paymentMethod;
    String? paymentStatus;
    String? orderStatus;
    int? pointsEarned;
    int? loyaltyPointsUsed;
    DateTime? createdAt;

    TtrancestionHistoryDataModel({
        this.id,
        this.orderId,
        this.tipAmount,
        this.totalAmount,
        this.paymentMethod,
        this.paymentStatus,
        this.orderStatus,
        this.pointsEarned,
        this.loyaltyPointsUsed,
        this.createdAt,
    });

    factory TtrancestionHistoryDataModel.fromRawJson(String str) => TtrancestionHistoryDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TtrancestionHistoryDataModel.fromJson(Map<String, dynamic> json) => TtrancestionHistoryDataModel(
        id: json["_id"],
        orderId: json["orderId"],
        tipAmount: json["tipAmount"],
        totalAmount: json["totalAmount"]?.toDouble(),
        paymentMethod: json["paymentMethod"],
        paymentStatus: json["paymentStatus"],
        orderStatus: json["orderStatus"],
        pointsEarned: json["pointsEarned"],
        loyaltyPointsUsed: json["loyaltyPointsUsed"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "orderId": orderId,
        "tipAmount": tipAmount,
        "totalAmount": totalAmount,
        "paymentMethod": paymentMethod,
        "paymentStatus": paymentStatus,
        "orderStatus": orderStatus,
        "pointsEarned": pointsEarned,
        "loyaltyPointsUsed": loyaltyPointsUsed,
        "createdAt": createdAt?.toIso8601String(),
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
