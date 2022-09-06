// To parse this JSON data, do
//
//     final makeOrderModel = makeOrderModelFromJson(jsonString);

import 'dart:convert';

MakeOrderModel makeOrderModelFromJson(String str) => MakeOrderModel.fromJson(json.decode(str));

String makeOrderModelToJson(MakeOrderModel data) => json.encode(data.toJson());

class MakeOrderModel {
  MakeOrderModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  Data? data;

  factory MakeOrderModel.fromJson(Map<String, dynamic> json) => MakeOrderModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.userId,
    this.driverId,
    this.userName,
    this.driverName,
    this.restaurantId,
    this.restaurantName,
    this.note,
    this.status,
    this.total,
    this.lat,
    this.long,
    this.products,
  });

  int? id;
  int? userId;
  int? driverId;
  String? userName;
  String? driverName;
  int? restaurantId;
  String? restaurantName;
  String? note;
  String? status;
  int? total;
  dynamic lat;
  dynamic long;
  List<Product>? products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        driverId: json["driver_id"],
        userName: json["user_name"],
        driverName: json["driver_name"],
        restaurantId: json["restaurant_id"],
        restaurantName: json["restaurant_name"],
        note: json["note"],
        status: json["status"],
        total: json["total"],
        lat: json["lat"],
        long: json["long"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "driver_id": driverId,
        "user_name": userName,
        "driver_name": driverName,
        "restaurant_id": restaurantId,
        "restaurant_name": restaurantName,
        "note": note,
        "status": status,
        "total": total,
        "lat": lat,
        "long": long,
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.id,
    this.productId,
    this.productName,
    this.quantity,
    this.sizeId,
    this.size,
    this.extras,
    this.note,
    this.price,
  });

  int? id;
  int? productId;
  String? productName;
  int? quantity;
  int? sizeId;
  String? size;
  List<Extra>? extras;
  String? note;
  int? price;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        quantity: json["quantity"],
        sizeId: json["size_id"],
        size: json["size"],
        extras: List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x))),
        note: json["note"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "quantity": quantity,
        "size_id": sizeId,
        "size": size,
        "extras": List<dynamic>.from(extras!.map((x) => x.toJson())),
        "note": note,
        "price": price,
      };
}

class Extra {
  Extra({
    this.id,
    this.name,
    this.price,
  });

  int? id;
  String? name;
  int? price;

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}
