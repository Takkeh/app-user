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
  List<RestaurantProducts>? data;

  factory ViewRestaurantModel.fromJson(Map<String, dynamic> json) => ViewRestaurantModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: List<RestaurantProducts>.from(json["data"].map((x) => RestaurantProducts.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class RestaurantProducts {
  RestaurantProducts({
    this.id,
    this.name,
    this.image,
    this.price,
    this.categorise,
    this.groups,
  });

  int? id;
  String? name;
  String? image;
  double? price;
  String? categorise;
  List<ProductGroup>? groups;

  factory RestaurantProducts.fromJson(Map<String, dynamic> json) => RestaurantProducts(
        id: json["id"],
        name: json["name"],
        image: json["image"] ?? '',
        price: double.parse(json["price"].toString()),
        categorise: json["categorise"],
        groups: List<ProductGroup>.from(json["groups"].map((x) => ProductGroup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "categorise": categorise,
        "groups": List<dynamic>.from(groups!.map((x) => x.toJson())),
      };
}

class ProductGroup {
  ProductGroup({
    this.id,
    this.name,
    this.type,
    this.items,
  });

  int? id;
  String? name;
  String? type;
  List<GroupItem>? items;

  factory ProductGroup.fromJson(Map<String, dynamic> json) => ProductGroup(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        items: List<GroupItem>.from(json["items"].map((x) => GroupItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class GroupItem {
  GroupItem({
    this.id,
    this.name,
    this.price,
  });

  int? id;
  String? name;
  double? price;

  factory GroupItem.fromJson(Map<String, dynamic> json) => GroupItem(
        id: json["id"],
        name: json["name "],
        price: double.parse(json["price"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name ": name,
        "price": price,
      };
}
