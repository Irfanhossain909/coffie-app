import 'dart:convert';

class ProfileModel {
    bool? success;
    String? message;
    Data? data;

    ProfileModel({
        this.success,
        this.message,
        this.data,
    });

    factory ProfileModel.fromRawJson(String str) => ProfileModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
    Location? location;
    String? id;
    String? name;
    String? email;
    String? role;
    String? address;
    String? profileImage;
    List<dynamic>? permissions;
    String? status;
    bool? isVerified;
    bool? isPhoneVerified;
    bool? isEmailVerified;
    bool? isDeleted;
    List<String>? authProviders;
    dynamic deviceToken;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    Customer? customer;
    String? phone;

    Data({
        this.location,
        this.id,
        this.name,
        this.email,
        this.role,
        this.address,
        this.profileImage,
        this.permissions,
        this.status,
        this.isVerified,
        this.isPhoneVerified,
        this.isEmailVerified,
        this.isDeleted,
        this.authProviders,
        this.deviceToken,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.customer,
        this.phone,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        address: json["address"],
        profileImage: json["profileImage"],
        permissions: json["permissions"] == null ? [] : List<dynamic>.from(json["permissions"]!.map((x) => x)),
        status: json["status"],
        isVerified: json["isVerified"],
        isPhoneVerified: json["isPhoneVerified"],
        isEmailVerified: json["isEmailVerified"],
        isDeleted: json["isDeleted"],
        authProviders: json["authProviders"] == null ? [] : List<String>.from(json["authProviders"]!.map((x) => x)),
        deviceToken: json["deviceToken"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "_id": id,
        "name": name,
        "email": email,
        "role": role,
        "address": address,
        "profileImage": profileImage,
        "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x)),
        "status": status,
        "isVerified": isVerified,
        "isPhoneVerified": isPhoneVerified,
        "isEmailVerified": isEmailVerified,
        "isDeleted": isDeleted,
        "authProviders": authProviders == null ? [] : List<dynamic>.from(authProviders!.map((x) => x)),
        "deviceToken": deviceToken,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "customer": customer?.toJson(),
        "phone": phone,
    };
}

class Customer {
    String? id;
    int? loyaltyPoints;

    Customer({
        this.id,
        this.loyaltyPoints,
    });

    factory Customer.fromRawJson(String str) => Customer.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["_id"],
        loyaltyPoints: json["loyaltyPoints"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "loyaltyPoints": loyaltyPoints,
    };
}

class Location {
    double? latitude;
    double? longitude;

    Location({
        this.latitude,
        this.longitude,
    });

    factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}
