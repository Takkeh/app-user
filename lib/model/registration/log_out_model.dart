import 'dart:convert';

class LogOutModel {
  LogOutModel({
    this.status,
    this.code,
    this.msg,
  });

  bool? status;
  int? code;
  String? msg;

  LogOutModel updateProfileModelFromJson(String str) => LogOutModel.fromJson(json.decode(str));

  String updateProfileModelToJson() => json.encode(toJson());

  factory LogOutModel.fromJson(Map<String, dynamic> json) => LogOutModel(
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
