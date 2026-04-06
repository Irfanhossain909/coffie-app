import 'dart:convert';

class OrderCardModel {
    bool? success;
    String? message;
    Pagination? pagination;
    List<OrderCardDataModel>? data;

    OrderCardModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory OrderCardModel.fromRawJson(String str) => OrderCardModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OrderCardModel.fromJson(Map<String, dynamic> json) => OrderCardModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<OrderCardDataModel>.from(json["data"]!.map((x) => OrderCardDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class OrderCardDataModel {
    String? id;
    String? orderId;
    String? orderStatus;
    int? totalItems;
    double? orderTotal;
    List<String>? productNames;
    int? readyTime;
    String? previewImage;

    OrderCardDataModel({
        this.id,
        this.orderId,
        this.orderStatus,
        this.totalItems,
        this.orderTotal,
        this.productNames,
        this.readyTime,
        this.previewImage,
    });

    factory OrderCardDataModel.fromRawJson(String str) => OrderCardDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OrderCardDataModel.fromJson(Map<String, dynamic> json) => OrderCardDataModel(
        id: json["_id"],
        orderId: json["orderId"],
        orderStatus: json["orderStatus"],
        totalItems: json["totalItems"],
        orderTotal: json["orderTotal"]?.toDouble(),
        productNames: json["productNames"] == null ? [] : List<String>.from(json["productNames"]!.map((x) => x)),
        readyTime: json["readyTime"],
        previewImage: json["previewImage"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "orderId": orderId,
        "orderStatus": orderStatus,
        "totalItems": totalItems,
        "orderTotal": orderTotal,
        "productNames": productNames == null ? [] : List<dynamic>.from(productNames!.map((x) => x)),
        "readyTime": readyTime,
        "previewImage": previewImage,
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
