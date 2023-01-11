// To parse this JSON data, do
//
//     final specialOffersModel = specialOffersModelFromJson(jsonString);

import 'dart:convert';

SpecialOffersModel specialOffersModelFromJson(String str) => SpecialOffersModel.fromJson(json.decode(str));

String specialOffersModelToJson(SpecialOffersModel data) => json.encode(data.toJson());

class SpecialOffersModel {
  SpecialOffersModel({
    this.status,
    this.code,
    this.msg,
    this.specials,
  });

  bool? status;
  int? code;
  String? msg;
  List<Special>? specials;

  factory SpecialOffersModel.fromJson(Map<String, dynamic> json) => SpecialOffersModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        specials: List<Special>.from(json["Specials"].map((x) => Special.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "Specials": List<dynamic>.from(specials!.map((x) => x.toJson())),
      };
}

class Special {
  Special({
    this.id,
    this.image,
  });

  int? id;
  String? image;

  factory Special.fromJson(Map<String, dynamic> json) => Special(
        id: json["id"],
        image: json["image"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
