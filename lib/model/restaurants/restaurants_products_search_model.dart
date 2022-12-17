// To parse this JSON data, do
//
//     final restaurantProductsSearch = restaurantProductsSearchFromJson(jsonString);

import 'dart:convert';

import 'package:takkeh/model/restaurants/khaled_model.dart';

RestaurantProductsSearchModel restaurantProductsSearchFromJson(String str) => RestaurantProductsSearchModel.fromJson(json.decode(str));

String restaurantProductsSearchToJson(RestaurantProductsSearchModel data) => json.encode(data.toJson());

class RestaurantProductsSearchModel {
  RestaurantProductsSearchModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  Data? data;

  factory RestaurantProductsSearchModel.fromJson(Map<String, dynamic> json) => RestaurantProductsSearchModel(
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
    this.cost,
    this.time,
    this.isBusy,
    this.description,
    this.reviewAverage,
    this.review,
    this.reviewIcon,
    this.products,
  });

  int? id;
  String? name;
  String? logo;
  String? cover;
  int? cost;
  String? time;
  int? isBusy;
  String? description;
  double? reviewAverage;
  String? review;
  String? reviewIcon;
  List<Product>? products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        cover: json["cover"],
        cost: json["cost"],
        time: json["time"],
        isBusy: json["is_busy"],
        description: json["description"],
        reviewAverage: double.parse(json["review_average"].toString()),
        review: json["review"],
        reviewIcon: json["review_icon"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "cover": cover,
        "cost": cost,
        "time": time,
        "is_busy": isBusy,
        "description": description,
        "review_average": reviewAverage,
        "review": review,
        "review_icon": reviewIcon,
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.id,
    this.name,
    this.image,
    this.soldQuantity,
    this.description,
    this.price,
    this.groups,
  });

  int? id;
  String? name;
  String? image;
  int? soldQuantity;
  String? description;
  double? price;
  List<ProductGroups>? groups;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        image: json["image"] ?? '',
        soldQuantity: json["sold_quantity"],
        description: json["description"],
        price: double.parse(json["price"].toString()),
        groups: List<ProductGroups>.from(json["groups"].map((x) => ProductGroups.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "sold_quantity": soldQuantity,
        "description": description,
        "price": price,
        "groups": List<ProductGroups>.from(groups!.map((x) => x.toJson())),
      };
}
