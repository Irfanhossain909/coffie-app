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

class GiftCardModel {
  bool? success;
  String? message;
  Pagination? pagination;
  List<GiftCardDataModel>? data;

  GiftCardModel({
    this.success,
    this.message,
    this.pagination,
    this.data,
  });

  factory GiftCardModel.fromRawJson(String str) =>
      GiftCardModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GiftCardModel.fromJson(Map<String, dynamic> json) {
    return GiftCardModel(
      success: json["success"],
      message: safeString(json["message"]),
      pagination: json["pagination"] == null
          ? null
          : Pagination.fromJson(json["pagination"]),
      data: json["data"] == null
          ? []
          : List<GiftCardDataModel>.from(
              json["data"].map((x) => GiftCardDataModel.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data?.map((x) => x.toJson()).toList(),
      };
}

/// =======================
/// DATA MODEL
/// =======================

class GiftCardDataModel {
  String? id;
  String? cardNumber;
  double? amount;
  double? currentBalance;
  String? sender;
  String? receiverEmail;
  String? receiverName;
  String? message;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  GiftCardDataModel({
    this.id,
    this.cardNumber,
    this.amount,
    this.currentBalance,
    this.sender,
    this.receiverEmail,
    this.receiverName,
    this.message,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory GiftCardDataModel.fromJson(Map<String, dynamic> json) {
    return GiftCardDataModel(
      id: safeString(json["_id"]),
      cardNumber: safeString(json["cardNumber"]),
      amount: safeDouble(json["amount"]),
      currentBalance: safeDouble(json["currentBalance"]),
      sender: safeString(json["sender"]),
      receiverEmail: safeString(json["receiverEmail"]),
      receiverName: safeString(json["receiverName"]),
      message: safeString(json["message"]),
      status: safeString(json["status"]),
      createdAt: json["createdAt"] == null
          ? null
          : DateTime.tryParse(json["createdAt"].toString()),
      updatedAt: json["updatedAt"] == null
          ? null
          : DateTime.tryParse(json["updatedAt"].toString()),
      v: safeInt(json["__v"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "cardNumber": cardNumber,
        "amount": amount,
        "currentBalance": currentBalance,
        "sender": sender,
        "receiverEmail": receiverEmail,
        "receiverName": receiverName,
        "message": message,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

/// =======================
/// PAGINATION
/// =======================

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

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: safeInt(json["total"]),
      limit: safeInt(json["limit"]),
      page: safeInt(json["page"]),
      totalPage: safeInt(json["totalPage"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "total": total,
        "limit": limit,
        "page": page,
        "totalPage": totalPage,
      };
}





// import 'dart:convert';

// class GiftCardModel {
//     bool? success;
//     String? message;
//     Pagination? pagination;
//     List<GiftCardDataModel>? data;

//     GiftCardModel({
//         this.success,
//         this.message,
//         this.pagination,
//         this.data,
//     });

//     factory GiftCardModel.fromRawJson(String str) => GiftCardModel.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory GiftCardModel.fromJson(Map<String, dynamic> json) => GiftCardModel(
//         success: json["success"],
//         message: json["message"],
//         pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
//         data: json["data"] == null ? [] : List<GiftCardDataModel>.from(json["data"]!.map((x) => GiftCardDataModel.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "pagination": pagination?.toJson(),
//         "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//     };
// }

// class GiftCardDataModel {
//     String? id;
//     String? cardNumber;
//     double? amount;
//     double? currentBalance;
//     String? sender;
//     String? receiverEmail;
//     String? receiverName;
//     String? message;
//     String? status;
//     DateTime? createdAt;
//     DateTime? updatedAt;
//     int? v;

//     GiftCardDataModel({
//         this.id,
//         this.cardNumber,
//         this.amount,
//         this.currentBalance,
//         this.sender,
//         this.receiverEmail,
//         this.receiverName,
//         this.message,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//         this.v,
//     });

//     factory GiftCardDataModel.fromRawJson(String str) => GiftCardDataModel.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory GiftCardDataModel.fromJson(Map<String, dynamic> json) => GiftCardDataModel(
//         id: json["_id"],
//         cardNumber: json["cardNumber"],
//         amount: json["amount"]?.toDouble(),
//         currentBalance: json["currentBalance"]?.toDouble(),
//         sender: json["sender"],
//         receiverEmail: json["receiverEmail"],
//         receiverName: json["receiverName"],
//         message: json["message"],
//         status: json["status"],
//         createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "cardNumber": cardNumber,
//         "amount": amount,
//         "currentBalance": currentBalance,
//         "sender": sender,
//         "receiverEmail": receiverEmail,
//         "receiverName": receiverName,
//         "message": message,
//         "status": status,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//     };
// }

// class Pagination {
//     int? total;
//     int? limit;
//     int? page;
//     int? totalPage;

//     Pagination({
//         this.total,
//         this.limit,
//         this.page,
//         this.totalPage,
//     });

//     factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

//     String toRawJson() => json.encode(toJson());

//     factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
//         total: json["total"],
//         limit: json["limit"],
//         page: json["page"],
//         totalPage: json["totalPage"],
//     );

//     Map<String, dynamic> toJson() => {
//         "total": total,
//         "limit": limit,
//         "page": page,
//         "totalPage": totalPage,
//     };
// }
