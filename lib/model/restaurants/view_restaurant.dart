// To parse this JSON data, do
//
//     final viewRestaurantModel = viewRestaurantModelFromJson(jsonString);

import 'dart:convert';

ViewRestaurantModel viewRestaurantModelFromJson(String str) => ViewRestaurantModel.fromJson(json.decode(str));

String viewRestaurantModelToJson(ViewRestaurantModel data) => json.encode(data.toJson());

class ViewRestaurantModel {
  ViewRestaurantModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  Data? data;

  factory ViewRestaurantModel.fromJson(Map<String, dynamic> json) => ViewRestaurantModel(
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
  List<ViewRestaurants>? products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        cover: json["cover"],
        time: json["time"],
        products: List<ViewRestaurants>.from(json["products"].map((x) => ViewRestaurants.fromJson(x))),
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

class ViewRestaurants {
  ViewRestaurants({
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
  List<Extras>? extras;

  factory ViewRestaurants.fromJson(Map<String, dynamic> json) => ViewRestaurants(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        categorise: json["categorise"],
        sizes: List<Sizes>.from(json["sizes"].map((x) => Sizes.fromJson(x))),
        extras: List<Extras>.from(json["extras"].map((x) => Extras.fromJson(x))),
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

class Extras {
  Extras({
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

  factory Extras.fromJson(Map<String, dynamic> json) => Extras(
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
