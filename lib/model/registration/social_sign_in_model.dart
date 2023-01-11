// To parse this JSON data, do
//
//     final socialSignInModel = socialSignInModelFromJson(jsonString);

import 'dart:convert';

SocialSignInModel socialSignInModelFromJson(String str) => SocialSignInModel.fromJson(json.decode(str));

String socialSignInModelToJson(SocialSignInModel data) => json.encode(data.toJson());

class SocialSignInModel {
  SocialSignInModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  Data? data;

  factory SocialSignInModel.fromJson(Map<String, dynamic> json) => SocialSignInModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.token,
    this.user,
  });

  String? token;
  User? user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user!.toJson(),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.lname,
    this.email,
    this.phone,
    this.image,
    this.type,
    this.otp,
  });

  int? id;
  String? name;
  String? lname;
  String? email;
  String? phone;
  String? image;
  String? type;
  String? otp;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"] ?? '',
        lname: json["lname"] ?? '',
        email: json["email"] ?? '',
        phone: json["phone"] == null ? '' : json["phone"].toString(),
        image: json["image"] ?? '',
        type: json["type"] ?? '',
        otp: json["otp"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lname": lname,
        "email": email,
        "phone": phone,
        "image": image,
        "type": type,
        "otp": otp,
      };
}
