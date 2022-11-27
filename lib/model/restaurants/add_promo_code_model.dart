// To parse this JSON data, do
//
//     final addPromoCodeModel = addPromoCodeModelFromJson(jsonString);

import 'dart:convert';

AddPromoCodeModel addPromoCodeModelFromJson(String str) => AddPromoCodeModel.fromJson(json.decode(str));

String addPromoCodeModelToJson(AddPromoCodeModel data) => json.encode(data.toJson());

class AddPromoCodeModel {
  AddPromoCodeModel({
    this.status,
    this.code,
    this.msg,
  });

  bool? status;
  int? code;
  String? msg;

  factory AddPromoCodeModel.fromJson(Map<String, dynamic> json) => AddPromoCodeModel(
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
