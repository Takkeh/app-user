// To parse this JSON data, do
//
//     final viewRestaurantModel = viewRestaurantModelFromJson(jsonString);

import 'dart:convert';

import 'package:takkeh/model/restaurants/groups_model.dart';

ViewRestaurantModel viewRestaurantModelFromJson(String str) => ViewRestaurantModel.fromJson(json.decode(str));

String viewRestaurantModelToJson(ViewRestaurantModel data) => json.encode(data.toJson());

class ViewRestaurantModel {
  ViewRestaurantModel({
    this.status,
    this.code,
    this.msg,
    this.categories,
  });

  bool? status;
  int? code;
  String? msg;
  List<RestaurantProducts>? categories;

  factory ViewRestaurantModel.fromJson(Map<String, dynamic> json) => ViewRestaurantModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        categories: List<RestaurantProducts>.from(json["categories"].map((x) => RestaurantProducts.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class RestaurantProducts {
  RestaurantProducts({
    this.id,
    this.name,
    this.products,
  });

  int? id;
  String? name;
  List<Product>? products;

  factory RestaurantProducts.fromJson(Map<String, dynamic> json) => RestaurantProducts(
        id: json["id"],
        name: json["name"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.id,
    this.name,
    this.image,
    this.price,
    this.description,
    this.groups,
  });

  int? id;
  String? name;
  String? description;
  String? image;
  double? price;
  List<ProductGroups>? groups;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        image: json["image"] ?? '',
        description: json["description"] ?? '',
        price: double.parse(json["price"].toString()),
        groups: List<ProductGroups>.from(json["groups"].map((x) => ProductGroups.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "description": description,
        "groups": List<ProductGroups>.from(groups!.map((x) => x.toJson())),
      };
}
