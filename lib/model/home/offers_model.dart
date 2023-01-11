import 'package:takkeh/model/restaurants/restaurants_model.dart';
import 'package:takkeh/model/restaurants/view_restaurant.dart';

class OffersModel {
  OffersModel({
    this.status,
    this.code,
    this.msg,
    this.offers,
  });

  OffersModel.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    if (json['Offers'] != null) {
      offers = [];
      json['Offers'].forEach((v) {
        offers?.add(Offers.fromJson(v));
      });
    }
  }
  bool? status;
  int? code;
  String? msg;
  List<Offers>? offers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['code'] = code;
    map['msg'] = msg;
    if (offers != null) {
      map['Offers'] = offers?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Offers {
  Offers({
    this.id,
    this.image,
    this.route,
    this.restaurant,
    this.product,
  });

  int? id;
  String? image;
  String? route;
  RestaurantList? restaurant;
  ProductInfo? product;

  Offers.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'] ?? '';
    route = json['route'];
    restaurant = json['restaurant'] == null ? null : RestaurantList.fromJson(json['restaurant']);
    product = json['product'] == null ? null : ProductInfo.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['route'] = route;
    map['restaurant'] = restaurant!.toJson();
    map['restaurant'] = product!.toJson();
    return map;
  }
}
