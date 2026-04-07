import 'dart:convert';

class SingleProductModel {
    bool? success;
    String? message;
    Data? data;

    SingleProductModel({
        this.success,
        this.message,
        this.data,
    });

    factory SingleProductModel.fromRawJson(String str) => SingleProductModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SingleProductModel.fromJson(Map<String, dynamic> json) => SingleProductModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? id;
    String? store;
    String? name;
    String? description;
    String? image;
    String? category;
    double? basePrice;
    List<Customization>? customizations;
    List<String>? dietaryLabels;
    int? readyTime;
    bool? isActive;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    bool? isFavorite;

    Data({
        this.id,
        this.store,
        this.name,
        this.description,
        this.image,
        this.category,
        this.basePrice,
        this.customizations,
        this.dietaryLabels,
        this.readyTime,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.isFavorite,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        store: json["store"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        category: json["category"],
        basePrice: json["basePrice"]?.toDouble(),
        customizations: json["customizations"] == null ? [] : List<Customization>.from(json["customizations"]!.map((x) => Customization.fromJson(x))),
        dietaryLabels: json["dietaryLabels"] == null ? [] : List<String>.from(json["dietaryLabels"]!.map((x) => x)),
        readyTime: json["readyTime"],
        isActive: json["isActive"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        isFavorite: json["isFavorite"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "store": store,
        "name": name,
        "description": description,
        "image": image,
        "category": category,
        "basePrice": basePrice,
        "customizations": customizations == null ? [] : List<dynamic>.from(customizations!.map((x) => x.toJson())),
        "dietaryLabels": dietaryLabels == null ? [] : List<dynamic>.from(dietaryLabels!.map((x) => x)),
        "readyTime": readyTime,
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "isFavorite": isFavorite,
    };
}

class Customization {
    String? name;
    String? type;
    bool? isRequired;
    List<Option>? options;
    String? id;
    double? pricePerUnit;

    Customization({
        this.name,
        this.type,
        this.isRequired,
        this.options,
        this.id,
        this.pricePerUnit,
    });

    factory Customization.fromRawJson(String str) => Customization.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Customization.fromJson(Map<String, dynamic> json) => Customization(
        name: json["name"],
        type: json["type"],
        isRequired: json["isRequired"],
        options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
        id: json["_id"],
        pricePerUnit: json["pricePerUnit"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "isRequired": isRequired,
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
        "_id": id,
        "pricePerUnit": pricePerUnit,
    };
}

class Option {
    String? label;
    double? price;
    String? id;

    Option({
        this.label,
        this.price,
        this.id,
    });

    factory Option.fromRawJson(String str) => Option.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        label: json["label"],
        price: json["price"]?.toDouble(),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "price": price,
        "_id": id,
    };
}
