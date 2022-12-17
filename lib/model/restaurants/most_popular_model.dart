// To parse this JSON data, do
//
//     final mostPopularProductsModel = mostPopularProductsModelFromJson(jsonString);

import 'dart:convert';

import 'package:takkeh/model/restaurants/khaled_model.dart';

MostPopularProductsModel mostPopularProductsModelFromJson(String str) => MostPopularProductsModel.fromJson(json.decode(str));

String mostPopularProductsModelToJson(MostPopularProductsModel data) => json.encode(data.toJson());

class MostPopularProductsModel {
  MostPopularProductsModel({
    this.status,
    this.code,
    this.msg,
    this.mostPopular,
  });

  bool? status;
  int? code;
  String? msg;
  MostPopular? mostPopular;

  factory MostPopularProductsModel.fromJson(Map<String, dynamic> json) => MostPopularProductsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        mostPopular: MostPopular.fromJson(json["retaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "retaurant": mostPopular!.toJson(),
      };
}

class MostPopular {
  MostPopular({
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
    this.mostPopularProducts,
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
  List<MostPopularProducts>? mostPopularProducts;

  factory MostPopular.fromJson(Map<String, dynamic> json) => MostPopular(
        id: json["id"],
        name: json["name"] ?? '',
        logo: json["logo"] ?? '',
        cover: json["cover"] ?? '',
        cost: json["cost"],
        time: json["time"],
        isBusy: json["is_busy"],
        description: json["description"],
        reviewAverage: json["review_average"] == null ? 0.0 : double.parse(json["review_average"].toString()),
        review: json["review"],
        reviewIcon: json["review_icon"],
        mostPopularProducts: List<MostPopularProducts>.from(json["products"].map((x) => MostPopularProducts.fromJson(x))),
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
        "products": List<dynamic>.from(mostPopularProducts!.map((x) => x.toJson())),
      };
}

class MostPopularProducts {
  MostPopularProducts({
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

  factory MostPopularProducts.fromJson(Map<String, dynamic> json) => MostPopularProducts(
        id: json["id"],
        name: json["name"] ?? '',
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
