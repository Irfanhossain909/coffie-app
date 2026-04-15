import 'dart:convert';

/// =======================
/// SAFE PARSERS
/// =======================

double? safeDouble(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString());
}

int? safeInt(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString());
}

String? safeString(dynamic value) {
  if (value == null) return null;
  return value.toString();
}

/// =======================
/// MAIN MODEL
/// =======================

class WalletDetailsModel {
  bool? success;
  String? message;
  Data? data;

  WalletDetailsModel({
    this.success,
    this.message,
    this.data,
  });

  factory WalletDetailsModel.fromRawJson(String str) =>
      WalletDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WalletDetailsModel.fromJson(Map<String, dynamic> json) {
    return WalletDetailsModel(
      success: json["success"],
      message: safeString(json["message"]),
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

/// =======================
/// DATA MODEL
/// =======================

class Data {
  String? id;
  String? title;
  String? type;

  double? amount;
  String? status;
  DateTime? createdAt;

  double? balanceAfter;
  double? previousBalance;

  RelatedOrder? relatedOrder;

  Data({
    this.id,
    this.title,
    this.type,
    this.amount,
    this.status,
    this.createdAt,
    this.balanceAfter,
    this.previousBalance,
    this.relatedOrder,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: safeString(json["_id"]),
      title: safeString(json["title"]),
      type: safeString(json["type"]),

      amount: safeDouble(json["amount"]) ?? 0.0,
      status: safeString(json["status"]),

      createdAt: json["createdAt"] == null
          ? null
          : DateTime.tryParse(json["createdAt"].toString()),

      balanceAfter: safeDouble(json["balanceAfter"]) ?? 0.0,
      previousBalance: safeDouble(json["previousBalance"]) ?? 0.0,

      relatedOrder: json["relatedOrder"] == null
          ? null
          : RelatedOrder.fromJson(json["relatedOrder"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "type": type,
        "amount": amount,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "balanceAfter": balanceAfter,
        "previousBalance": previousBalance,
        "relatedOrder": relatedOrder?.toJson(),
      };
}

/// =======================
/// RELATED ORDER
/// =======================

class RelatedOrder {
  String? id;
  String? orderId;
  String? storeName;
  dynamic distanceKm;
  List<Item>? items;

  RelatedOrder({
    this.id,
    this.orderId,
    this.storeName,
    this.distanceKm,
    this.items,
  });

  factory RelatedOrder.fromJson(Map<String, dynamic> json) {
    return RelatedOrder(
      id: safeString(json["_id"]),
      orderId: safeString(json["orderId"]),
      storeName: safeString(json["storeName"]),

      // distance can be string/int/double → keep raw safe
      distanceKm: safeDouble(json["distanceKm"]) ?? json["distanceKm"],

      items: json["items"] == null
          ? []
          : List<Item>.from(
              json["items"].map((x) => Item.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "orderId": orderId,
        "storeName": storeName,
        "distanceKm": distanceKm,
        "items": items?.map((x) => x.toJson()).toList(),
      };
}

/// =======================
/// ITEM MODEL
/// =======================

class Item {
  String? name;
  int? quantity;
  double? price;

  Item({
    this.name,
    this.quantity,
    this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: safeString(json["name"]),
      quantity: safeInt(json["quantity"]),
      price: safeDouble(json["price"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
        "price": price,
      };
}




// import 'dart:convert';

// class WalletDetailsModel {
//   bool? success;
//   String? message;
//   Data? data;

//   WalletDetailsModel({this.success, this.message, this.data});

//   factory WalletDetailsModel.fromRawJson(String str) =>
//       WalletDetailsModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory WalletDetailsModel.fromJson(Map<String, dynamic> json) =>
//       WalletDetailsModel(
//         success: json["success"],
//         message: json["message"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "message": message,
//     "data": data?.toJson(),
//   };
// }

// class Data {
//   String? id;
//   String? title;
//   String? type;
//   double? amount;
//   String? status;
//   DateTime? createdAt;
//   double? balanceAfter;
//   double? previousBalance;
//   RelatedOrder? relatedOrder;

//   Data({
//     this.id,
//     this.title,
//     this.type,
//     this.amount,
//     this.status,
//     this.createdAt,
//     this.balanceAfter,
//     this.previousBalance,
//     this.relatedOrder,
//   });

//   factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     id: json["_id"],
//     title: json["title"],
//     type: json["type"],
//     amount: json["amount"] != null ? (json["amount"] as num).toDouble() : 0.0,
//     status: json["status"],
//     createdAt: json["createdAt"] == null
//         ? null
//         : DateTime.parse(json["createdAt"]),
//     balanceAfter: json["balanceAfter"] != null
//         ? (json["balanceAfter"] as num).toDouble()
//         : 0.0,

//     previousBalance: json["previousBalance"] != null
//         ? (json["previousBalance"] as num).toDouble()
//         : 0.0,
//     relatedOrder: json["relatedOrder"] == null
//         ? null
//         : RelatedOrder.fromJson(json["relatedOrder"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "title": title,
//     "type": type,
//     "amount": amount,
//     "status": status,
//     "createdAt": createdAt?.toIso8601String(),
//     "balanceAfter": balanceAfter,
//     "previousBalance": previousBalance,
//     "relatedOrder": relatedOrder?.toJson(),
//   };
// }

// class RelatedOrder {
//   String? id;
//   String? orderId;
//   String? storeName;
//   dynamic distanceKm;
//   List<Item>? items;

//   RelatedOrder({
//     this.id,
//     this.orderId,
//     this.storeName,
//     this.distanceKm,
//     this.items,
//   });

//   factory RelatedOrder.fromRawJson(String str) =>
//       RelatedOrder.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory RelatedOrder.fromJson(Map<String, dynamic> json) => RelatedOrder(
//     id: json["_id"],
//     orderId: json["orderId"],
//     storeName: json["storeName"],
//     distanceKm: json["distanceKm"],
//     items: json["items"] == null
//         ? []
//         : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
//   );

//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "orderId": orderId,
//     "storeName": storeName,
//     "distanceKm": distanceKm,
//     "items": items == null
//         ? []
//         : List<dynamic>.from(items!.map((x) => x.toJson())),
//   };
// }

// class Item {
//   String? name;
//   int? quantity;
//   double? price;

//   Item({this.name, this.quantity, this.price});

//   factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Item.fromJson(Map<String, dynamic> json) => Item(
//     name: json["name"],
//     quantity: json["quantity"],
//     price: json["price"]?.toDouble(),
//   );

//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "quantity": quantity,
//     "price": price,
//   };
// }
