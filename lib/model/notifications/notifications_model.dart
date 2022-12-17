// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) => NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) => json.encode(data.toJson());

class NotificationsModel {
  NotificationsModel({
    this.notification,
    this.data,
  });

  Notification? notification;
  Data? data;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
        notification: Notification.fromJson(json["notification"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "notification": notification!.toJson(),
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.route,
    this.title,
    this.cost,
    this.time,
    this.reviewIcon,
    this.cover,
    this.logo,
    this.review,
    this.phone,
  });

  int? id;
  String? route;
  String? title;
  String? cost;
  String? time;
  String? reviewIcon;
  String? cover;
  String? logo;
  String? review;
  String? phone;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        route: json["route"],
        title: json["title"],
        cost: json["cost"],
        time: json["time"],
        reviewIcon: json["reviewIcon"],
        cover: json["cover"],
        logo: json["logo"],
        review: json["review"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "route": route,
        "title": title,
        "cost": cost,
        "time": time,
        "reviewIcon": reviewIcon,
        "cover": cover,
        "logo": logo,
        "review": review,
        "phone": phone,
      };
}

class Notification {
  Notification({
    this.title,
    this.body,
  });

  String? title;
  String? body;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
      };
}
