import 'dart:convert';

class FavorireProductModel {
    bool? success;
    String? message;
    Pagination? pagination;
    List<FavorireProductDataModel>? data;

    FavorireProductModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory FavorireProductModel.fromRawJson(String str) => FavorireProductModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FavorireProductModel.fromJson(Map<String, dynamic> json) => FavorireProductModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<FavorireProductDataModel>.from(json["data"]!.map((x) => FavorireProductDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class FavorireProductDataModel {
    String? id;
    String? user;
    Product? product;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    FavorireProductDataModel({
        this.id,
        this.user,
        this.product,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory FavorireProductDataModel.fromRawJson(String str) => FavorireProductDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FavorireProductDataModel.fromJson(Map<String, dynamic> json) => FavorireProductDataModel(
        id: json["_id"],
        user: json["user"],
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "product": product?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Product {
    String? id;
    String? name;
    String? image;
    double? basePrice;
    List<String>? dietaryLabels;
    int? readyTime;

    Product({
        this.id,
        this.name,
        this.image,
        this.basePrice,
        this.dietaryLabels,
        this.readyTime,
    });

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        basePrice: json["basePrice"]?.toDouble(),
        dietaryLabels: json["dietaryLabels"] == null ? [] : List<String>.from(json["dietaryLabels"]!.map((x) => x)),
        readyTime: json["readyTime"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "basePrice": basePrice,
        "dietaryLabels": dietaryLabels == null ? [] : List<dynamic>.from(dietaryLabels!.map((x) => x)),
        "readyTime": readyTime,
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
