import 'dart:convert';

class RewardCardModel {
    bool? success;
    String? message;
    Pagination? pagination;
    List<Datum>? data;

    RewardCardModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory RewardCardModel.fromRawJson(String str) => RewardCardModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RewardCardModel.fromJson(Map<String, dynamic> json) => RewardCardModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? id;
    String? user;
    int? pointsChange;
    String? type;
    int? balanceAfter;
    RelatedOrderId? relatedOrderId;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Datum({
        this.id,
        this.user,
        this.pointsChange,
        this.type,
        this.balanceAfter,
        this.relatedOrderId,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        user: json["user"],
        pointsChange: json["pointsChange"],
        type: json["type"],
        balanceAfter: json["balanceAfter"],
        relatedOrderId: json["relatedOrderId"] == null ? null : RelatedOrderId.fromJson(json["relatedOrderId"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "pointsChange": pointsChange,
        "type": type,
        "balanceAfter": balanceAfter,
        "relatedOrderId": relatedOrderId?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class RelatedOrderId {
    String? id;
    Store? store;
    String? orderId;
    double? totalAmount;
    DateTime? createdAt;

    RelatedOrderId({
        this.id,
        this.store,
        this.orderId,
        this.totalAmount,
        this.createdAt,
    });

    factory RelatedOrderId.fromRawJson(String str) => RelatedOrderId.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RelatedOrderId.fromJson(Map<String, dynamic> json) => RelatedOrderId(
        id: json["_id"],
        store: json["store"] == null ? null : Store.fromJson(json["store"]),
        orderId: json["orderId"],
        totalAmount: json["totalAmount"]?.toDouble(),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "store": store?.toJson(),
        "orderId": orderId,
        "totalAmount": totalAmount,
        "createdAt": createdAt?.toIso8601String(),
    };
}

class Store {
    String? id;
    String? name;
    String? image;
    String? address;

    Store({
        this.id,
        this.name,
        this.image,
        this.address,
    });

    factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "address": address,
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
