// // To parse this JSON data, do
// //
// //     final specialOffersModel = specialOffersModelFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:takkeh/model/restaurants/restaurants_model.dart';
// import 'package:takkeh/model/restaurants/view_restaurant.dart';
//
// SpecialOffersModel specialOffersModelFromJson(String str) => SpecialOffersModel.fromJson(json.decode(str));
//
// String specialOffersModelToJson(SpecialOffersModel data) => json.encode(data.toJson());
//
// class SpecialOffersModel {
//   SpecialOffersModel({
//     this.status,
//     this.code,
//     this.msg,
//     this.specials,
//   });
//
//   bool? status;
//   int? code;
//   String? msg;
//   List<Special>? specials;
//
//   factory SpecialOffersModel.fromJson(Map<String, dynamic> json) => SpecialOffersModel(
//         status: json["status"],
//         code: json["code"],
//         msg: json["msg"],
//         specials: List<Special>.from(json["Specials"].map((x) => Special.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "code": code,
//         "msg": msg,
//         "Specials": List<dynamic>.from(specials!.map((x) => x.toJson())),
//       };
// }
//
// class Special {
//   Special({
//     this.id,
//     this.image,
//     this.route,
//     this.restaurant,
//     this.product,
//   });
//
//   int? id;
//   String? image;
//   String? route;
//   RestaurantList? restaurant;
//   ProductInfo? product;
//
//   factory Special.fromJson(Map<String, dynamic> json) => Special(
//         id: json["id"],
//         image: json["image"] ?? '',
//         route: json['route'],
//         restaurant: json['restaurant'] == null ? null : RestaurantList.fromJson(json['restaurant']),
//         product: json['product'] == null ? null : ProductInfo.fromJson(json['product']),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "image": image,
//         "route": route,
//         "restaurant": restaurant!.toJson(),
//         "product": product!.toJson(),
//       };
// }
