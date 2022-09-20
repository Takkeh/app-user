// To parse this JSON data, do
//
//     final restaurantsModel = restaurantsModelFromJson(jsonString);

import 'dart:convert';

RestaurantsModel restaurantsModelFromJson(String str) => RestaurantsModel.fromJson(json.decode(str));

String restaurantsModelToJson(RestaurantsModel data) => json.encode(data.toJson());

class RestaurantsModel {
  RestaurantsModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  List<Restaurants>? data;

  factory RestaurantsModel.fromJson(Map<String, dynamic> json) => RestaurantsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: List<Restaurants>.from(json["data"].map((x) => Restaurants.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Restaurants {
  Restaurants({
    this.id,
    this.name,
    this.logo,
    this.cover,
    this.reviewIcon,
    this.review,
    this.cost,
    this.time,
    this.categories,
  });

  int? id;
  String? name;
  String? logo;
  String? cover;
  String? reviewIcon;
  String? review;
  String? cost;
  String? time;
  List<Category>? categories;

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        cover: json["cover"],
        reviewIcon: json["review_icon"],
        review: json["review"],
        cost: json["cost"],
        time: json["time"],
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "cover": cover,
        "review_icon": reviewIcon,
        "review": review,
        "cost": cost,
        "time": time,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
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
