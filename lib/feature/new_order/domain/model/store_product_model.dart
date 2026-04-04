import 'dart:convert';

class StoreProjectModel {
    bool? success;
    String? message;
    Pagination? pagination;
    List<StoreProjectDataModel>? data;

    StoreProjectModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory StoreProjectModel.fromRawJson(String str) => StoreProjectModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory StoreProjectModel.fromJson(Map<String, dynamic> json) => StoreProjectModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<StoreProjectDataModel>.from(json["data"]!.map((x) => StoreProjectDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class StoreProjectDataModel {
    String? id;
    String? store;
    String? name;
    String? image;
    String? category;
    double? basePrice;
    List<String>? dietaryLabels;
    int? readyTime;
    bool? isFavorite;

    StoreProjectDataModel({
        this.id,
        this.store,
        this.name,
        this.image,
        this.category,
        this.basePrice,
        this.dietaryLabels,
        this.readyTime,
        this.isFavorite,
    });

    factory StoreProjectDataModel.fromRawJson(String str) => StoreProjectDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory StoreProjectDataModel.fromJson(Map<String, dynamic> json) => StoreProjectDataModel(
        id: json["_id"],
        store: json["store"],
        name: json["name"],
        image: json["image"],
        category: json["category"],
        basePrice: json["basePrice"]?.toDouble(),
        dietaryLabels: json["dietaryLabels"] == null ? [] : List<String>.from(json["dietaryLabels"]!.map((x) => x)),
        readyTime: json["readyTime"],
        isFavorite: json["isFavorite"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "store": store,
        "name": name,
        "image": image,
        "category": category,
        "basePrice": basePrice,
        "dietaryLabels": dietaryLabels == null ? [] : List<dynamic>.from(dietaryLabels!.map((x) => x)),
        "readyTime": readyTime,
        "isFavorite": isFavorite,
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
