import 'dart:convert';

class StoreModel {
  bool? success;
  String? message;
  Pagination? pagination;
  List<StoreDataModel>? data;

  StoreModel({this.success, this.message, this.pagination, this.data});

  factory StoreModel.fromRawJson(String str) =>
      StoreModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
    success: json["success"],
    message: json["message"],
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
    data: json["data"] == null
        ? []
        : List<StoreDataModel>.from(
            json["data"]!.map((x) => StoreDataModel.fromJson(x)),
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

class StoreDataModel {
  Location? location;
  String? id;
  String? name;
  String? image;
  String? address;
  String? phone;
  List<Hour>? hours;
  bool? isConnectedAccountReady;
  bool? isActive;
  bool? isDeleted;
  String? about;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? timezone;
  int? v;
  String? stripeAccountId;
  bool? isFavorite;
  bool? isOpen;

  StoreDataModel({
    this.location,
    this.id,
    this.name,
    this.image,
    this.address,
    this.phone,
    this.hours,
    this.isConnectedAccountReady,
    this.isActive,
    this.isDeleted,
    this.about,
    this.createdAt,
    this.updatedAt,
    this.timezone,
    this.v,
    this.stripeAccountId,
    this.isFavorite,
    this.isOpen,
  });

  factory StoreDataModel.fromRawJson(String str) =>
      StoreDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreDataModel.fromJson(Map<String, dynamic> json) => StoreDataModel(
    location: json["location"] == null
        ? null
        : Location.fromJson(json["location"]),
    id: json["_id"],
    name: json["name"],
    image: json["image"],
    address: json["address"],
    phone: json["phone"],
    hours: json["hours"] == null
        ? []
        : List<Hour>.from(json["hours"]!.map((x) => Hour.fromJson(x))),
    isConnectedAccountReady: json["isConnectedAccountReady"],
    isActive: json["isActive"],
    isDeleted: json["isDeleted"],
    about: json["about"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    timezone: json["timezone"],
    v: json["__v"],
    stripeAccountId: json["stripeAccountId"],
    isFavorite: json["isFavorite"],
    isOpen: json["isOpen"],
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "_id": id,
    "name": name,
    "image": image,
    "address": address,
    "phone": phone,
    "hours": hours == null
        ? []
        : List<dynamic>.from(hours!.map((x) => x.toJson())),
    "isConnectedAccountReady": isConnectedAccountReady,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "about": about,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "timezone": timezone,
    "__v": v,
    "stripeAccountId": stripeAccountId,
    "isFavorite": isFavorite,
    "isOpen": isOpen,
  };
}

class Hour {
  String? day;
  String? open;
  String? close;

  Hour({this.day, this.open, this.close});

  factory Hour.fromRawJson(String str) => Hour.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hour.fromJson(Map<String, dynamic> json) =>
      Hour(day: json["day"], open: json["open"], close: json["close"]);

  Map<String, dynamic> toJson() => {"day": day, "open": open, "close": close};
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: json["coordinates"] == null
        ? []
        : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null
        ? []
        : List<dynamic>.from(coordinates!.map((x) => x)),
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
