// To parse this JSON data, do
//
//     final updateOrderModel = updateOrderModelFromJson(jsonString);

import 'dart:convert';

RestaurantsSearchModel updateOrderModelFromJson(String str) => RestaurantsSearchModel.fromJson(json.decode(str));

String updateOrderModelToJson(RestaurantsSearchModel data) => json.encode(data.toJson());

class RestaurantsSearchModel {
  RestaurantsSearchModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  List<Datum>? data;

  factory RestaurantsSearchModel.fromJson(Map<String, dynamic> json) => RestaurantsSearchModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.logo,
    this.cover,
    this.time,
    this.products,
  });

  int? id;
  String? name;
  String? logo;
  String? cover;
  String? time;
  List<Product>? products;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        cover: json["cover"],
        time: json["time"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "cover": cover,
        "time": time,
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  Product({
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
  List<Sizes>? sizes;
  List<Extra>? extras;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        categorise: json["categorise"],
        sizes: List<Sizes>.from(json["sizes"].map((x) => Sizes.fromJson(x))),
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

class Sizes {
  Sizes({
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

  factory Sizes.fromJson(Map<String, dynamic> json) => Sizes(
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
