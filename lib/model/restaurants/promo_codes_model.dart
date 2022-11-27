// To parse this JSON data, do
//
//     final promoCodesModel = promoCodesModelFromJson(jsonString);

import 'dart:convert';

PromoCodesModel promoCodesModelFromJson(String str) => PromoCodesModel.fromJson(json.decode(str));

String promoCodesModelToJson(PromoCodesModel data) => json.encode(data.toJson());

class PromoCodesModel {
  PromoCodesModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  List<Datum>? data;

  factory PromoCodesModel.fromJson(Map<String, dynamic> json) => PromoCodesModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.code,
    this.type,
    this.value,
  });

  int? id;
  String? name;
  String? code;
  String? type;
  int? value;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "type": type,
        "value": value,
      };
}
