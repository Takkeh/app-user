// To parse this JSON data, do
//
//     final mostPopularProductsModel = mostPopularProductsModelFromJson(jsonString);

import 'dart:convert';

MostPopularProductsModel mostPopularProductsModelFromJson(String str) => MostPopularProductsModel.fromJson(json.decode(str));

String mostPopularProductsModelToJson(MostPopularProductsModel data) => json.encode(data.toJson());

class MostPopularProductsModel {
  MostPopularProductsModel({
    this.status,
    this.code,
    this.msg,
    this.categorys,
  });

  bool? status;
  int? code;
  String? msg;
  List<Category>? categorys;

  factory MostPopularProductsModel.fromJson(Map<String, dynamic> json) => MostPopularProductsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        categorys: List<Category>.from(json["Categorys"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "Categorys": List<dynamic>.from(categorys!.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.image,
  });

  int? id;
  String? name;
  String? image;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
