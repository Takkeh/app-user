import 'dart:convert';

class MyOrdersModel {
  MyOrdersModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  List<OrdersList>? data;

  MyOrdersModel myOrdersModelFromJson(String str) => MyOrdersModel.fromJson(json.decode(str));

  String myOrdersModelToJson() => json.encode(toJson());

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) => MyOrdersModel(
    status: json["status"],
    code: json["code"],
    msg: json["msg"],
    data: List<OrdersList>.from(json["data"].map((x) => OrdersList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class OrdersList {
  OrdersList({
    this.id,
    this.restaurantId,
    this.restaurantName,
    this.restaurantLogo,
    this.orderNumber,
    this.createdAt,
  });

  int? id;
  String? restaurantId;
  dynamic restaurantName;
  dynamic restaurantLogo;
  int? orderNumber;
  DateTime? createdAt;

  OrdersList ordersListFromJson(String str) => OrdersList.fromJson(json.decode(str));

  String ordersListToJson() => json.encode(toJson());

  factory OrdersList.fromJson(Map<String, dynamic> json) => OrdersList(
    id: json["id"],
    restaurantId: json["restaurant_id"],
    restaurantName: json["restaurant_name"],
    restaurantLogo: json["restaurant_logo"]??'',
    orderNumber: json["order_number"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "restaurant_id": restaurantId,
    "restaurant_name": restaurantName,
    "restaurant_logo": restaurantLogo,
    "order_number": orderNumber,
    "created_at": createdAt!.toIso8601String(),
  };
}
