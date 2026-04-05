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
    List<dynamic>? permissions;
    bool? isPhoneVerified;
    bool? isEmailVerified;
    List<dynamic>? authProviders;
    dynamic deviceToken;
    String? id;
    String? name;
    String? role;
    String? email;
    String? phone;
    String? image;
    String? status;
    bool? isVerified;
    bool? isDeleted;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? profileImage;
    String? address;

    Data({
        this.permissions,
        this.isPhoneVerified,
        this.isEmailVerified,
        this.authProviders,
        this.deviceToken,
        this.id,
        this.name,
        this.role,
        this.email,
        this.phone,
        this.image,
        this.status,
        this.isVerified,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.profileImage,
        this.address,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        permissions: json["permissions"] == null ? [] : List<dynamic>.from(json["permissions"]!.map((x) => x)),
        isPhoneVerified: json["isPhoneVerified"],
        isEmailVerified: json["isEmailVerified"],
        authProviders: json["authProviders"] == null ? [] : List<dynamic>.from(json["authProviders"]!.map((x) => x)),
        deviceToken: json["deviceToken"],
        id: json["_id"],
        name: json["name"],
        role: json["role"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        status: json["status"],
        isVerified: json["isVerified"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        profileImage: json["profileImage"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "permissions": permissions == null ? [] : List<dynamic>.from(permissions!.map((x) => x)),
        "isPhoneVerified": isPhoneVerified,
        "isEmailVerified": isEmailVerified,
        "authProviders": authProviders == null ? [] : List<dynamic>.from(authProviders!.map((x) => x)),
        "deviceToken": deviceToken,
        "_id": id,
        "name": name,
        "role": role,
        "email": email,
        "phone": phone,
        "image": image,
        "status": status,
        "isVerified": isVerified,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "profileImage": profileImage,
        "address": address,
    };
}
