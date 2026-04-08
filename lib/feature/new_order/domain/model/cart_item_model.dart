import 'dart:convert';

class CartItemModel {
    bool? success;
    String? message;
    Data? data;

    CartItemModel({
        this.success,
        this.message,
        this.data,
    });

    factory CartItemModel.fromRawJson(String str) => CartItemModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
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
    String? user;
    List<Item>? items;
    double? totalPrice;
    int? totalQuantity;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Data({
        this.id,
        this.user,
        this.items,
        this.totalPrice,
        this.totalQuantity,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        user: json["user"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        totalPrice: json["totalPrice"]?.toDouble(),
        totalQuantity: json["totalQuantity"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "totalQuantity": totalQuantity,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Item {
    Product? product;
    String? productName;
    double? basePrice;
    int? quantity;
    List<SelectedCustomization>? selectedCustomizations;
    double? unitFinalPrice;
    double? itemTotalPrice;
    String? id;

    Item({
        this.product,
        this.productName,
        this.basePrice,
        this.quantity,
        this.selectedCustomizations,
        this.unitFinalPrice,
        this.itemTotalPrice,
        this.id,
    });

    factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        productName: json["productName"],
        basePrice: json["basePrice"]?.toDouble(),
        quantity: json["quantity"],
        selectedCustomizations: json["selectedCustomizations"] == null ? [] : List<SelectedCustomization>.from(json["selectedCustomizations"]!.map((x) => SelectedCustomization.fromJson(x))),
        unitFinalPrice: json["unitFinalPrice"]?.toDouble(),
        itemTotalPrice: json["itemTotalPrice"]?.toDouble(),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "product": product?.toJson(),
        "productName": productName,
        "basePrice": basePrice,
        "quantity": quantity,
        "selectedCustomizations": selectedCustomizations == null ? [] : List<dynamic>.from(selectedCustomizations!.map((x) => x.toJson())),
        "unitFinalPrice": unitFinalPrice,
        "itemTotalPrice": itemTotalPrice,
        "_id": id,
    };
}

class Product {
    String? id;
    String? name;
    String? image;
    int? readyTime;

    Product({
        this.id,
        this.name,
        this.image,
        this.readyTime,
    });

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        readyTime: json["readyTime"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "readyTime": readyTime,
    };
}

class SelectedCustomization {
    CustomizationId? customizationId;
    Name? name;
    String? optionId;
    String? optionLabel;
    double? optionPrice;
    int? quantity;
    double? pricePerUnit;
    double? totalPrice;

    SelectedCustomization({
        this.customizationId,
        this.name,
        this.optionId,
        this.optionLabel,
        this.optionPrice,
        this.quantity,
        this.pricePerUnit,
        this.totalPrice,
    });

    factory SelectedCustomization.fromRawJson(String str) => SelectedCustomization.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SelectedCustomization.fromJson(Map<String, dynamic> json) => SelectedCustomization(
        customizationId: customizationIdValues.map[json["customizationId"]]!,
        name: nameValues.map[json["name"]]!,
        optionId: json["optionId"],
        optionLabel: json["optionLabel"],
        optionPrice: json["optionPrice"]?.toDouble(),
        quantity: json["quantity"],
        pricePerUnit: json["pricePerUnit"]?.toDouble(),
        totalPrice: json["totalPrice"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "customizationId": customizationIdValues.reverse[customizationId],
        "name": nameValues.reverse[name],
        "optionId": optionId,
        "optionLabel": optionLabel,
        "optionPrice": optionPrice,
        "quantity": quantity,
        "pricePerUnit": pricePerUnit,
        "totalPrice": totalPrice,
    };
}

enum CustomizationId {
    THE_69_D32_DE99_C7_A9_D309_DF01245,
    THE_69_D4772240394741574001_C6,
    THE_69_D47948403947415740024_B
}

final customizationIdValues = EnumValues({
    "69d32de99c7a9d309df01245": CustomizationId.THE_69_D32_DE99_C7_A9_D309_DF01245,
    "69d4772240394741574001c6": CustomizationId.THE_69_D4772240394741574001_C6,
    "69d47948403947415740024b": CustomizationId.THE_69_D47948403947415740024_B
});

enum Name {
    FLAVOUR,
    MILK_TYPE,
    OTHERS
}

final nameValues = EnumValues({
    "Flavour": Name.FLAVOUR,
    "Milk Type": Name.MILK_TYPE,
    "others": Name.OTHERS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
