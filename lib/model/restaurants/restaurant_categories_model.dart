// To parse this JSON data, do
//
//     final restaurantCategoriesModel = restaurantCategoriesModelFromJson(jsonString);

import 'dart:convert';

RestaurantCategoriesModel restaurantCategoriesModelFromJson(String str) => RestaurantCategoriesModel.fromJson(json.decode(str));

String restaurantCategoriesModelToJson(RestaurantCategoriesModel data) => json.encode(data.toJson());

class RestaurantCategoriesModel {
  RestaurantCategoriesModel({
    this.status,
    this.code,
    this.msg,
    this.categorys,
  });

  bool? status;
  int? code;
  String? msg;
  List<Category>? categorys;

  factory RestaurantCategoriesModel.fromJson(Map<String, dynamic> json) => RestaurantCategoriesModel(
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
