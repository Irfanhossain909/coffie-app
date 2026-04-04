import 'dart:convert';

class StoreCategoryModel {
    bool? success;
    String? message;
    List<StoreCategoryDataModel>? data;

    StoreCategoryModel({
        this.success,
        this.message,
        this.data,
    });

    factory StoreCategoryModel.fromRawJson(String str) => StoreCategoryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory StoreCategoryModel.fromJson(Map<String, dynamic> json) => StoreCategoryModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<StoreCategoryDataModel>.from(json["data"]!.map((x) => StoreCategoryDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class StoreCategoryDataModel {
    String? id;
    String? name;
    bool? isActive;
    bool? isDeleted;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    StoreCategoryDataModel({
        this.id,
        this.name,
        this.isActive,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory StoreCategoryDataModel.fromRawJson(String str) => StoreCategoryDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory StoreCategoryDataModel.fromJson(Map<String, dynamic> json) => StoreCategoryDataModel(
        id: json["_id"],
        name: json["name"],
        isActive: json["isActive"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
