import 'dart:convert';

class NotificationModel {
    bool? success;
    String? message;
    Pagination? pagination;
    List<NotificationDataModel>? data;

    NotificationModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory NotificationModel.fromRawJson(String str) => NotificationModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<NotificationDataModel>.from(json["data"]!.map((x) => NotificationDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class NotificationDataModel {
    String? id;
    Receiver? receiver;
    String? title;
    String? message;
    Type? type;
    bool? isRead;
    Data? data;
    DateTime? createdAt;
    DateTime? updatedAt;

    NotificationDataModel({
        this.id,
        this.receiver,
        this.title,
        this.message,
        this.type,
        this.isRead,
        this.data,
        this.createdAt,
        this.updatedAt,
    });

    factory NotificationDataModel.fromRawJson(String str) => NotificationDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NotificationDataModel.fromJson(Map<String, dynamic> json) => NotificationDataModel(
        id: json["_id"],
        receiver: receiverValues.map[json["receiver"]]!,
        title: json["title"],
        message: json["message"],
        type: typeValues.map[json["type"]]!,
        isRead: json["isRead"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "receiver": receiverValues.reverse[receiver],
        "title": title,
        "message": message,
        "type": typeValues.reverse[type],
        "isRead": isRead,
        "data": data?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class Data {
    String? orderId;

    Data({
        this.orderId,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderId: json["orderId"],
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
    };
}

enum Receiver {
    THE_69_AE7_B7_D6_DBE6_A39473_D316_D
}

final receiverValues = EnumValues({
    "69ae7b7d6dbe6a39473d316d": Receiver.THE_69_AE7_B7_D6_DBE6_A39473_D316_D
});

enum Type {
    DAILY_SPECIAL,
    ORDER,
    PROMOTION
}

final typeValues = EnumValues({
    "DAILY_SPECIAL": Type.DAILY_SPECIAL,
    "ORDER": Type.ORDER,
    "PROMOTION": Type.PROMOTION
});

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

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
