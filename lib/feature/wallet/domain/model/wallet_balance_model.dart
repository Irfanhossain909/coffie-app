import 'dart:convert';

/// =======================
/// SAFE PARSER
/// =======================

double? safeDouble(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString());
}

String? safeString(dynamic value) {
  if (value == null) return null;
  return value.toString();
}

/// =======================
/// MAIN MODEL
/// =======================

class WalletBalanceModel {
  bool? success;
  String? message;
  Data? data;

  WalletBalanceModel({
    this.success,
    this.message,
    this.data,
  });

  factory WalletBalanceModel.fromRawJson(String str) =>
      WalletBalanceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WalletBalanceModel.fromJson(Map<String, dynamic> json) {
    return WalletBalanceModel(
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
  double? balance;

  Data({
    this.id,
    this.balance,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: safeString(json["_id"]),
      balance: safeDouble(json["balance"]) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "balance": balance,
      };
}



// import 'dart:convert';

// class WalletBalanceModel {
//   bool? success;
//   String? message;
//   Data? data;

//   WalletBalanceModel({this.success, this.message, this.data});

//   factory WalletBalanceModel.fromRawJson(String str) =>
//       WalletBalanceModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory WalletBalanceModel.fromJson(Map<String, dynamic> json) =>
//       WalletBalanceModel(
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
//   double? balance;

//   Data({this.id, this.balance});

//   factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     id: json["_id"],
//     balance: json["balance"] == null
//         ? 0.0
//         : double.tryParse(json["balance"].toString()) ?? 0.0,
//   );

//   Map<String, dynamic> toJson() => {"_id": id, "balance": balance};
// }
