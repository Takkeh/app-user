// To parse this JSON data, do
//
//     final myAddressesModel = myAddressesModelFromJson(jsonString);

import 'dart:convert';

MyAddressesModel myAddressesModelFromJson(String str) => MyAddressesModel.fromJson(json.decode(str));

String myAddressesModelToJson(MyAddressesModel data) => json.encode(data.toJson());

class MyAddressesModel {
  MyAddressesModel({
    this.status,
    this.code,
    this.msg,
    this.myAddresses,
  });

  bool? status;
  int? code;
  String? msg;
  List<MyAddresses>? myAddresses;

  factory MyAddressesModel.fromJson(Map<String, dynamic> json) => MyAddressesModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        myAddresses: List<MyAddresses>.from(json["data"].map((x) => MyAddresses.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(myAddresses!.map((x) => x.toJson())),
      };
}

class MyAddresses {
  MyAddresses({
    this.id,
    this.name,
    this.city,
    this.region,
    this.street,
    this.buildingNumber,
    this.floorNumber,
    this.apartmentNumber,
    this.additionalTips,
    this.userId,
    this.long,
    this.lat,
    this.phone,
  });

  int? id;
  String? name;
  String? city;
  String? region;
  String? street;
  String? buildingNumber;
  String? floorNumber;
  String? apartmentNumber;
  String? additionalTips;
  int? userId;
  double? long;
  double? lat;
  String? phone;

  factory MyAddresses.fromJson(Map<String, dynamic> json) => MyAddresses(
        id: json["id"],
        name: json["name"],
        city: json["city"],
        region: json["region"],
        street: json["street"],
        buildingNumber: json["building_number"],
        floorNumber: json["floor_number"],
        apartmentNumber: json["apartment_number"],
        additionalTips: json["additional_tips"],
        userId: json["user_id"],
        long: double.parse(json["long"].toString()),
        lat: double.parse(json["lat"].toString()),
        phone: json["phone"] == null ? '' : json["phone"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
        "region": region,
        "street": street,
        "building_number": buildingNumber,
        "floor_number": floorNumber,
        "apartment_number": apartmentNumber,
        "additional_tips": additionalTips,
        "user_id": userId,
        "long": long,
        "lat": lat,
        "phone": phone,
      };
}
