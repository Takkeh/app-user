// To parse this JSON data, do
//
//     final viewRestaurantProductModel = viewRestaurantProductModelFromJson(jsonString);

import 'dart:convert';

ViewRestaurantProductModel viewRestaurantProductModelFromJson(String str) => ViewRestaurantProductModel.fromJson(json.decode(str));

String viewRestaurantProductModelToJson(ViewRestaurantProductModel data) => json.encode(data.toJson());

class ViewRestaurantProductModel {
  ViewRestaurantProductModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  Data? data;

  factory ViewRestaurantProductModel.fromJson(Map<String, dynamic> json) => ViewRestaurantProductModel(
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
    this.name,
    this.price,
    this.categorise,
    this.sizes,
    this.extras,
  });

  int? id;
  String? name;
  int? price;
  String? categorise;
  List<Extra>? sizes;
  List<Extra>? extras;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        categorise: json["categorise"],
        sizes: List<Extra>.from(json["sizes"].map((x) => Extra.fromJson(x))),
        extras: List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "categorise": categorise,
        "sizes": List<dynamic>.from(sizes!.map((x) => x.toJson())),
        "extras": List<dynamic>.from(extras!.map((x) => x.toJson())),
      };
}

class Extra {
  Extra({
    this.id,
    this.price,
    this.name,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? price;
  String? name;
  int? productId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        id: json["id"],
        price: json["price"],
        name: json["name"],
        productId: json["product_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "name": name,
        "product_id": productId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
