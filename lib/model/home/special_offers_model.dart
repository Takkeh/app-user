// To parse this JSON data, do
//
//     final specialOffersModel = specialOffersModelFromJson(jsonString);

import 'dart:convert';

import 'package:takkeh/model/home/offers_model.dart';
import 'package:takkeh/model/restaurants/restaurants_model.dart';
import 'package:takkeh/model/restaurants/view_restaurant.dart';

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
  List<Offers>? specials;

  factory SpecialOffersModel.fromJson(Map<String, dynamic> json) => SpecialOffersModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        specials: List<Offers>.from(json["Specials"].map((x) => Offers.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "Specials": List<dynamic>.from(specials!.map((x) => x.toJson())),
      };
}
