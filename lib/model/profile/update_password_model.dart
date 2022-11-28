import 'dart:convert';

class UpdatePasswordModel {
  UpdatePasswordModel({
    this.status,
    this.code,
    this.msg,
  });

  bool? status;
  int? code;
  String? msg;

  UpdatePasswordModel updateProfileModelFromJson(String str) => UpdatePasswordModel.fromJson(json.decode(str));

  String updateProfileModelToJson() => json.encode(toJson());

  factory UpdatePasswordModel.fromJson(Map<String, dynamic> json) => UpdatePasswordModel(
    status: json["status"],
    code: json["code"],
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "msg": msg,
  };
}
