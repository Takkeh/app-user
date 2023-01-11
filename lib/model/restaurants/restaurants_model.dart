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
    this.description,
    this.isBusy,
    this.reviewAverage,
    this.review,
    this.phone,
  });

  int? id;
  String? name;
  String? logo;
  String? cover;
  String? reviewIcon;
  String? phone;
  String? cost;
  String? time;
  String? description;
  int? isBusy;
  double? reviewAverage;
  String? review;

  factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        cover: json["cover"],
        reviewIcon: json["review_icon"],
        cost: json["cost"].toString(),
        time: json["time"],
        description: json["description"],
        isBusy: json["is_busy"],
        phone: json["phone"] == null ? '' : json["phone"].toString(),
        reviewAverage: json["review_average"] != null ? double.parse(json["review_average"].toString()) : 4.0,
        review: json["review"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "cover": cover,
        "review_icon": reviewIcon,
        "cost": cost,
        "time": time,
        "description": description,
        "is_busy": isBusy,
        "review_average": reviewAverage,
        "review": review,
        "phone": phone,
      };
}
