import 'dart:convert';

class GiftCardRedemModel {
    bool? success;
    String? message;
    Pagination? pagination;
    List<GiftCardRedemDataModel>? data;

    GiftCardRedemModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory GiftCardRedemModel.fromRawJson(String str) => GiftCardRedemModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GiftCardRedemModel.fromJson(Map<String, dynamic> json) => GiftCardRedemModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<GiftCardRedemDataModel>.from(json["data"]!.map((x) => GiftCardRedemDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class GiftCardRedemDataModel {
    String? id;
    String? user;
    GiftCard? giftCard;
    String? type;
    double? amount;
    double? balanceAfter;
    String? transactionId;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    RelatedOrder? relatedOrder;

    GiftCardRedemDataModel({
        this.id,
        this.user,
        this.giftCard,
        this.type,
        this.amount,
        this.balanceAfter,
        this.transactionId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.relatedOrder,
    });

    factory GiftCardRedemDataModel.fromRawJson(String str) => GiftCardRedemDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GiftCardRedemDataModel.fromJson(Map<String, dynamic> json) => GiftCardRedemDataModel(
        id: json["_id"],
        user: json["user"],
        giftCard: json["giftCard"] == null ? null : GiftCard.fromJson(json["giftCard"]),
        type: json["type"],
        amount: json["amount"]?.toDouble(),
        balanceAfter: json["balanceAfter"]?.toDouble(),
        transactionId: json["transactionId"],
        status: json["status"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        relatedOrder: json["relatedOrder"] == null ? null : RelatedOrder.fromJson(json["relatedOrder"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "giftCard": giftCard?.toJson(),
        "type": type,
        "amount": amount,
        "balanceAfter": balanceAfter,
        "transactionId": transactionId,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "relatedOrder": relatedOrder?.toJson(),
    };
}

class GiftCard {
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

    GiftCard({
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

    factory GiftCard.fromRawJson(String str) => GiftCard.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GiftCard.fromJson(Map<String, dynamic> json) => GiftCard(
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

class RelatedOrder {
    String? id;
    Store? store;
    String? orderId;

    RelatedOrder({
        this.id,
        this.store,
        this.orderId,
    });

    factory RelatedOrder.fromRawJson(String str) => RelatedOrder.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RelatedOrder.fromJson(Map<String, dynamic> json) => RelatedOrder(
        id: json["_id"],
        store: json["store"] == null ? null : Store.fromJson(json["store"]),
        orderId: json["orderId"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "store": store?.toJson(),
        "orderId": orderId,
    };
}

class Store {
    String? id;
    String? name;

    Store({
        this.id,
        this.name,
    });

    factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
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
