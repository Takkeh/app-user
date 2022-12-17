// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) => NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) => json.encode(data.toJson());

class NotificationsModel {
  NotificationsModel({
    this.restaurantId,
    this.route,
    this.title,
    this.cost,
    this.time,
    this.reviewIcon,
    this.cover,
    this.logo,
    this.review,
    this.phone,
    this.productId,
    this.price,
    this.description,
    this.groups,
    this.orderId,
  });

  int? restaurantId;
  int? productId;
  int? orderId;
  double? price;
  String? route;
  String? title;
  String? cost;
  String? time;
  String? reviewIcon;
  String? cover;
  String? logo;
  String? review;
  String? phone;
  String? description;
  List<dynamic>? groups;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
        restaurantId: json["restaurant_id"] == null ? null : int.parse(json["restaurant_id"].toString()),
        productId: json["product_id"] == null ? null : int.parse(json["product_id"].toString()),
        orderId: json["orderId"] == null ? null : int.parse(json["orderId"].toString()),
        route: json["route"],
        title: json["title"],
        cost: json["cost"],
        time: json["time"],
        reviewIcon: json["reviewIcon"],
        cover: json["cover"],
        logo: json["logo"],
        review: json["review"],
        phone: json["phone"],
        price: json["price"] == null ? null : double.parse(json["price"].toString()),
        description: json["description"],
        groups: json["groups"] == null ? null : jsonDecode(json["groups"]),
      );

  Map<String, dynamic> toJson() => {
        "restaurant_id": restaurantId,
        "product_id": productId,
        "route": route,
        "title": title,
        "cost": cost,
        "time": time,
        "reviewIcon": reviewIcon,
        "cover": cover,
        "logo": logo,
        "review": review,
        "phone": phone,
        "price": price,
        "description": description,
        "groups": groups,
        "orderId": orderId,
      };
}
