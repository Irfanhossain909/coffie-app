import 'dart:convert';

class RewardCardDetailsModel {
  bool? success;
  String? message;
  Data? data;

  RewardCardDetailsModel({this.success, this.message, this.data});

  factory RewardCardDetailsModel.fromRawJson(String str) =>
      RewardCardDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RewardCardDetailsModel.fromJson(Map<String, dynamic> json) =>
      RewardCardDetailsModel(
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
  String? orderId;
  String? orderStatus;
  DateTime? createdAt;
  Store? store;
  int? readyTime;
  double? subtotal;
  int? taxAmount;
  int? tipAmount;
  int? discountAmount;
  double? totalAmount;
  String? paymentMethod;
  String? paymentStatus;
  int? pointsEarned;
  int? loyaltyPointsUsed;
  List<Item>? items;

  Data({
    this.id,
    this.orderId,
    this.orderStatus,
    this.createdAt,
    this.store,
    this.readyTime,
    this.subtotal,
    this.taxAmount,
    this.tipAmount,
    this.discountAmount,
    this.totalAmount,
    this.paymentMethod,
    this.paymentStatus,
    this.pointsEarned,
    this.loyaltyPointsUsed,
    this.items,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    orderId: json["orderId"],
    orderStatus: json["orderStatus"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    store: json["store"] == null ? null : Store.fromJson(json["store"]),
    readyTime: json["readyTime"],
    subtotal: json["subtotal"]?.toDouble(),
    taxAmount: json["taxAmount"],
    tipAmount: json["tipAmount"],
    discountAmount: json["discountAmount"],
    totalAmount: json["totalAmount"]?.toDouble(),
    paymentMethod: json["paymentMethod"],
    paymentStatus: json["paymentStatus"],
    pointsEarned: json["pointsEarned"],
    loyaltyPointsUsed: json["loyaltyPointsUsed"],
    items: json["items"] == null
        ? []
        : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "orderId": orderId,
    "orderStatus": orderStatus,
    "createdAt": createdAt?.toIso8601String(),
    "store": store?.toJson(),
    "readyTime": readyTime,
    "subtotal": subtotal,
    "taxAmount": taxAmount,
    "tipAmount": tipAmount,
    "discountAmount": discountAmount,
    "totalAmount": totalAmount,
    "paymentMethod": paymentMethod,
    "paymentStatus": paymentStatus,
    "pointsEarned": pointsEarned,
    "loyaltyPointsUsed": loyaltyPointsUsed,
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  String? id;
  String? productName;
  String? image;
  int? quantity;
  double? unitPrice;
  double? totalPrice;

  Item({
    this.id,
    this.productName,
    this.image,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["_id"],
    productName: json["productName"],
    image: json["image"],
    quantity: json["quantity"],
    unitPrice: json["unitPrice"]?.toDouble(),
    totalPrice: json["totalPrice"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productName": productName,
    "image": image,
    "quantity": quantity,
    "unitPrice": unitPrice,
    "totalPrice": totalPrice,
  };
}

class Store {
  String? id;
  String? name;
  String? address;
  String? image;
  dynamic distanceKm;

  Store({this.id, this.name, this.address, this.image, this.distanceKm});

  factory Store.fromRawJson(String str) => Store.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    image: json["image"],
    distanceKm: json["distanceKm"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "image": image,
    "distanceKm": distanceKm,
  };
}
