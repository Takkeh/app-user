// To parse this JSON data, do
//
//     final createAddressesModel = createAddressesModelFromJson(jsonString);

import 'dart:convert';

CreateAddressModel createAddressesModelFromJson(String str) => CreateAddressModel.fromJson(json.decode(str));

String createAddressesModelToJson(CreateAddressModel data) => json.encode(data.toJson());

class CreateAddressModel {
  CreateAddressModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  Data? data;

  factory CreateAddressModel.fromJson(Map<String, dynamic> json) => CreateAddressModel(
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
  String? long;
  String? lat;
  String? phone;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        long: json["long"],
        lat: json["lat"],
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
