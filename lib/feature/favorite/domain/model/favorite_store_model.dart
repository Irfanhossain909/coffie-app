import 'dart:convert';

class FavorireStoreModel {
    bool? success;
    String? message;
    Pagination? pagination;
    List<FavorireStoreDataModel>? data;

    FavorireStoreModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory FavorireStoreModel.fromRawJson(String str) => FavorireStoreModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FavorireStoreModel.fromJson(Map<String, dynamic> json) => FavorireStoreModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<FavorireStoreDataModel>.from(json["data"]!.map((x) => FavorireStoreDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class FavorireStoreDataModel {
    String? id;
    bool? isFavorite;
    String? user;
    Store? store;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    FavorireStoreDataModel({
        this.id,
        this.user,
        this.isFavorite,
        this.store,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory FavorireStoreDataModel.fromRawJson(String str) => FavorireStoreDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FavorireStoreDataModel.fromJson(Map<String, dynamic> json) => FavorireStoreDataModel(
        id: json["_id"],
        user: json["user"],
        isFavorite: json["isFavorite"] ?? false,
        store: json["store"] == null ? null : Store.fromJson(json["store"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "isFavorite": isFavorite,
        "store": store?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Store {
    String? id;
    String? name;
    String? image;
    String? address;
    List<Hour>? hours;

    Store({
        this.id,
        this.name,
        this.image,
        this.address,
        this.hours,
    });

    factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        address: json["address"],
        hours: json["hours"] == null ? [] : List<Hour>.from(json["hours"]!.map((x) => Hour.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "address": address,
        "hours": hours == null ? [] : List<dynamic>.from(hours!.map((x) => x.toJson())),
    };
}

class Hour {
    String? day;
    String? open;
    String? close;

    Hour({
        this.day,
        this.open,
        this.close,
    });

    factory Hour.fromRawJson(String str) => Hour.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        day: json["day"],
        open: json["open"],
        close: json["close"],
    );

    Map<String, dynamic> toJson() => {
        "day": day,
        "open": open,
        "close": close,
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
