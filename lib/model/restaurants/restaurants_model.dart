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
    this.categories,
    this.reviewIcon,
    this.review,
    this.cost,
    this.time,
  });

  int? id;
  String? name;
  String? logo;
  String? cover;
  String? categories;
  String? reviewIcon;
  String? review;
  String? cost;
  String? time;

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        cover: json["cover"],
        categories: json["categories"],
        reviewIcon: json["review_icon"],
        review: json["review"],
        cost: json["cost"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "cover": cover,
        "categories": categories,
        "review_icon": reviewIcon,
        "review": review,
        "cost": cost,
        "time": time,
      };
}
