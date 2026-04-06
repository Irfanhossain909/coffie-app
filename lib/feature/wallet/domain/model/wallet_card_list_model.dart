import 'dart:convert';

class WalletCardListModel {
  bool? success;
  String? message;
  Pagination? pagination;
  List<WalletCardListDataModel>? data;

  WalletCardListModel({this.success, this.message, this.pagination, this.data});

  factory WalletCardListModel.fromRawJson(String str) =>
      WalletCardListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WalletCardListModel.fromJson(Map<String, dynamic> json) =>
      WalletCardListModel(
        success: json["success"],
        message: json["message"],
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null
            ? []
            : List<WalletCardListDataModel>.from(
                json["data"]!.map((x) => WalletCardListDataModel.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "pagination": pagination?.toJson(),
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class WalletCardListDataModel {
  String? id;
  String? title;
  String? type;
  double? amount;
  String? status;
  DateTime? createdAt;
  dynamic image;

  WalletCardListDataModel({
    this.id,
    this.title,
    this.type,
    this.amount,
    this.status,
    this.createdAt,
    this.image,
  });

  factory WalletCardListDataModel.fromRawJson(String str) =>
      WalletCardListDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WalletCardListDataModel.fromJson(Map<String, dynamic> json) =>
      WalletCardListDataModel(
        id: json["_id"],
        title: json["title"],
        type: json["type"],
        amount: json["amount"] == null
            ? 0.0
            : double.tryParse(json["amount"].toString()) ?? 0.0,
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "type": type,
    "amount": amount,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "image": image,
  };
}

class Pagination {
  int? total;
  int? limit;
  int? page;
  int? totalPage;

  Pagination({this.total, this.limit, this.page, this.totalPage});

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

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
