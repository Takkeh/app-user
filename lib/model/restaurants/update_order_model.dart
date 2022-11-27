// To parse this JSON data, do
//
//     final updateOrderModel = updateOrderModelFromJson(jsonString);

import 'dart:convert';

UpdateOrderModel updateOrderModelFromJson(String str) => UpdateOrderModel.fromJson(json.decode(str));

String updateOrderModelToJson(UpdateOrderModel data) => json.encode(data.toJson());

class UpdateOrderModel {
  UpdateOrderModel({
    this.status,
    this.code,
    this.msg,
    this.order,
  });

  bool? status;
  int? code;
  String? msg;
  Order? order;

  factory UpdateOrderModel.fromJson(Map<String, dynamic> json) => UpdateOrderModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        order: Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "order": order!.toJson(),
      };
}

class Order {
  Order({
    this.id,
    this.restaurantId,
  });

  int? id;
  int? restaurantId;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        restaurantId: json["restaurant_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurant_id": restaurantId,
      };
}
