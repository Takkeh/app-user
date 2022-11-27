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
  List<RestaurantList>? data;

  factory RestaurantsModel.fromJson(Map<String, dynamic> json) => RestaurantsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: List<RestaurantList>.from(json["data"].map((x) => RestaurantList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class RestaurantList {
  RestaurantList({
    this.id,
    this.name,
    this.logo,
    this.cover,
    this.reviewIcon,
    this.cost,
    this.time,
    this.isBusy,
    this.description,
  });

  int? id;
  String? name;
  String? logo;
  String? cover;
  String? reviewIcon;
  String? cost;
  String? time;
  int? isBusy;
  String? description;

  factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        cover: json["cover"],
        reviewIcon: json["review_icon"] ?? '',
        cost: json["cost"],
        time: json["time"],
        isBusy: json["is_busy"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "cover": cover,
        "review_icon": reviewIcon,
        "cost": cost,
        "time": time,
        "is_busy": isBusy,
        "description": description,
      };
}
