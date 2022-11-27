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
  String? total;
  String? lat;
  String? long;
  List<UserProducts>? products;

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
        products: List<UserProducts>.from(json["products"].map((x) => UserProducts.fromJson(x))),
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

class UserProducts {
  UserProducts({
    this.id,
    this.productId,
    this.productName,
    this.productImage,
    this.quantity,
    this.items,
    this.note,
    this.price,
  });

  int? id;
  int? productId;
  String? productName;
  String? productImage;
  int? quantity;
  List<ProductItems>? items;
  String? note;
  double? price;

  factory UserProducts.fromJson(Map<String, dynamic> json) => UserProducts(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        productImage: json["product_image"] ?? '',
        quantity: json["quantity"],
        items: List<ProductItems>.from(json["items"].map((x) => ProductItems.fromJson(x))),
        note: json["note"],
        price: double.parse(json["price"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "product_image": productImage,
        "quantity": quantity,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "note": note,
        "price": price,
      };
}

class ProductItems {
  ProductItems({
    this.id,
    this.groupName,
    this.itemName,
    this.price,
  });

  int? id;
  String? groupName;
  String? itemName;
  double? price;

  factory ProductItems.fromJson(Map<String, dynamic> json) => ProductItems(
        id: json["id"],
        groupName: json["group_name"],
        itemName: json["item_name"] ?? '',
        price: double.parse(json["price"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_name": groupName,
        "item_name": itemName,
        "price": price,
      };
}
