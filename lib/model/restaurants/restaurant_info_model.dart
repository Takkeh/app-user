import 'dart:convert';

class RestaurantInfoModel {
  RestaurantInfoModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  Data? data;

  RestaurantInfoModel restaurantReviewsModelFromJson(String str) => RestaurantInfoModel.fromJson(json.decode(str));

  String restaurantReviewsModelToJson() => json.encode(toJson());

  factory RestaurantInfoModel.fromJson(Map<String, dynamic> json) => RestaurantInfoModel(
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
    this.address,
    this.phone,
    this.workTime,
    this.deliveryTime,
    this.minimum,
    this.deliveryFee,
    this.salesTax,
    this.isTaxable,
    this.reviews,
  });

  int? id;
  String? name;
  String? logo;
  String? cover;
  dynamic cost;
  String? time;
  int? isBusy;
  String? description;
  dynamic reviewAverage;
  String? review;
  String? reviewIcon;
  String? address;
  String? phone;
  String? workTime;
  String? deliveryTime;
  int? minimum;
  dynamic deliveryFee;
  dynamic salesTax;
  dynamic isTaxable;
  List<Review>? reviews;

  Data dataFromJson(String str) => Data.fromJson(json.decode(str));

  String dataToJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"]??'',
    logo: json["logo"]??'',
    cover: json["cover"]??'',
    cost: json["cost"]??0,
    time: json["time"]??'',
    isBusy: json["is_busy"],
    description: json["description"]??'',
    reviewAverage: json["review_average"]??0,
    review: json["review"]??'',
    reviewIcon: json["review_icon"]??'',
    address: json["address"]??'',
    phone: json["phone"]??'',
    workTime: json["Work_time"]??'',
    deliveryTime: json["delivery_time"]??'',
    minimum: json["minimum"]??0,
    deliveryFee: json["delivery_fee"]??0,
    salesTax: json["sales_tax"]??0,
    isTaxable: json["is_taxable"]??0,
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
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
    "address": address,
    "phone": phone,
    "Work_time": workTime,
    "delivery_time": deliveryTime,
    "minimum": minimum,
    "delivery_fee": deliveryFee,
    "sales_tax": salesTax,
    "is_taxable": isTaxable,
    "reviews": List<dynamic>.from(reviews!.map((x) => x.toJson())),
  };
}

class Review {
  Review({
    this.id,
    this.title,
    this.content,
    this.points,
    this.reviewString,
    this.reviewIcon,
    this.userImage,
    this.status,
  });

  int? id;
  String? title;
  String? content;
  String? points;
  String? reviewString;
  String? reviewIcon;
  String? userImage;
  int? status;

  Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

  String reviewToJson() => json.encode(toJson());

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    title: json["title"]??'',
    content: json["content"]??'',
    points: json["points"]??'',
    reviewString: json["review_string"]??'',
    reviewIcon: json["review_icon"]??'',
    userImage: json["user_image"]??'',
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "points": points,
    "review_string": reviewString,
    "review_icon": reviewIcon,
    "user_image": userImage,
    "status": status,
  };
}
