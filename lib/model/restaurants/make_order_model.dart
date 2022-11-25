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
    this.status,
    this.paymentMethod,
    this.note,
    this.type,
    this.lat,
    this.long,
    this.total,
    this.tax,
    this.deliveryFee,
    this.discount,
    this.percentage,
    this.number,
    this.orderValue,
    this.products,
    this.review,
  });

  int? id;
  String? status;
  String? paymentMethod;
  String? note;
  String? type;
  String? lat;
  String? long;
  String? total;
  String? tax;
  String? deliveryFee;
  String? discount;
  String? percentage;
  int? number;
  String? orderValue;
  List<UserProducts>? products;
  String? review;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        status: json["status"],
        paymentMethod: json["payment_method"],
        note: json["note"],
        type: json["type"],
        lat: json["lat"],
        long: json["long"],
        total: json["total"],
        tax: json["tax"],
        deliveryFee: json["delivery_fee"],
        discount: json["discount"],
        percentage: json["percentage"],
        number: json["number"],
        orderValue: json["order_value"],
        products: List<UserProducts>.from(json["products"].map((x) => UserProducts.fromJson(x))),
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "payment_method": paymentMethod,
        "note": note,
        "type": type,
        "lat": lat,
        "long": long,
        "total": total,
        "tax": tax,
        "delivery_fee": deliveryFee,
        "discount": discount,
        "percentage": percentage,
        "number": number,
        "order_value": orderValue,
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
        "review": review,
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
    this.area,
    this.price,
  });

  int? id;
  int? productId;
  String? productName;
  String? productImage;
  int? quantity;
  List<UserItems>? items;
  String? note;
  String? area;
  double? price;

  factory UserProducts.fromJson(Map<String, dynamic> json) => UserProducts(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        productImage: json["product_image"] ?? '',
        quantity: json["quantity"],
        items: List<UserItems>.from(json["items"].map((x) => UserItems.fromJson(x))),
        note: json["note"],
        area: json["area"],
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
        "area": area,
        "price": price,
      };
}

class UserItems {
  UserItems({
    this.id,
    this.groupName,
    this.itemName,
    this.price,
  });

  int? id;
  String? groupName;
  String? itemName;
  String? price;

  factory UserItems.fromJson(Map<String, dynamic> json) => UserItems(
        id: json["id"],
        groupName: json["group_name"],
        itemName: json["item_name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_name": groupName,
        "item_name": itemName,
        "price": price,
      };
}
