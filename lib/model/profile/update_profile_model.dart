import 'dart:convert';

class UpdateProfileModel {
  UpdateProfileModel({
    this.status,
    this.code,
    this.msg,
    this.user,
  });

  bool? status;
  int? code;
  String? msg;
  User? user;

  UpdateProfileModel updateProfileModelFromJson(String str) =>
      UpdateProfileModel.fromJson(json.decode(str));

  String updateProfileModelToJson() => json.encode(toJson());

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        user: json["user"]==null?null:User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "user": user==null?null: user!.toJson(),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.lastName,
    this.phone,
    this.email,
    this.image,
  });

  int? id;
  String? name;
  String? lastName;
  String? phone;
  String? email;
  String? image;

  User userFromJson(String str) => User.fromJson(json.decode(str));

  String userToJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"]??'',
        lastName: json["last_name"]??'',
        phone: json["phone"]??'',
        email: json["email"]??'',
        image: json["image"]??'',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "image": image,
      };
}
