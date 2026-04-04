import 'dart:convert';

class SliderModel {
    bool? success;
    String? message;
    Pagination? pagination;
    List<SliderDataModel>? data;

    SliderModel({
        this.success,
        this.message,
        this.pagination,
        this.data,
    });

    factory SliderModel.fromRawJson(String str) => SliderModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<SliderDataModel>.from(json["data"]!.map((x) => SliderDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class SliderDataModel {
    String? id;
    String? name;
    String? image;
    bool? isActive;
    DateTime? createdAt;
    DateTime? updatedAt;

    SliderDataModel({
        this.id,
        this.name,
        this.image,
        this.isActive,
        this.createdAt,
        this.updatedAt,
    });

    factory SliderDataModel.fromRawJson(String str) => SliderDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SliderDataModel.fromJson(Map<String, dynamic> json) => SliderDataModel(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        isActive: json["isActive"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
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
