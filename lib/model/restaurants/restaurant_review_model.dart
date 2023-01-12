import 'dart:convert';

class RestaurantReviewModel {
  RestaurantReviewModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  Data? data;

  RestaurantReviewModel restaurantReviewModelFromJson(String str) => RestaurantReviewModel.fromJson(json.decode(str));

  String restaurantReviewModelToJson() => json.encode(toJson());

  factory RestaurantReviewModel.fromJson(Map<String, dynamic> json) => RestaurantReviewModel(
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
    this.phone,
    this.reviewIcon,
    this.cost,
    this.time,
    this.isBusy,
    this.description,
    this.categories,
    this.tags,
    this.reviews,
  });

  int? id;
  String? name;
  String? logo;
  String? cover;
  String? phone;
  String? reviewIcon;
  int? cost;
  String? time;
  int? isBusy;
  String? description;
  List<Category?>? categories;
  List<Category?>? tags;
  List<Review?>? reviews;

  Data dataFromJson(String str) => Data.fromJson(json.decode(str));

  String dataToJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    cover: json["cover"],
    phone: json["phone"],
    reviewIcon: json["review_icon"],
    cost: json["cost"],
    time: json["time"],
    isBusy: json["is_busy"],
    description: json["description"],
    categories: json["categories"] == null ? [] : List<Category?>.from(json["categories"]!.map((x) => Category.fromJson(x))),
    tags: json["tags"] == null ? [] : List<Category?>.from(json["tags"]!.map((x) => Category.fromJson(x))),
    reviews: json["reviews"] == null ? [] : List<Review?>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "cover": cover,
    "phone": phone,
    "review_icon": reviewIcon,
    "cost": cost,
    "time": time,
    "is_busy": isBusy,
    "description": description,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x!.toJson())),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x!.toJson())),
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x!.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.image,
  });

  int? id;
  String? name;
  String? image;

  Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

  String categoryToJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}

class Review {
  Review({
    this.id,
    this.title,
    this.content,
    this.points,
    this.user,
    this.status,
  });

  int? id;
  String? title;
  String? content;
  String? points;
  User? user;
  int? status;

  Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

  String reviewToJson() => json.encode(toJson());

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    points: json["points"],
    user: User.fromJson(json["user"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "points": points,
    "user": user!.toJson(),
    "status": status,
  };
}

class User {
  User({
    this.id,
    this.name,
    this.lastName,
    this.phone,
    this.email,
    this.deviceToken,
    this.image,
    this.active,
    this.lat,
    this.long,
    this.online,
  });

  int? id;
  String? name;
  String? lastName;
  String? phone;
  String? email;
  dynamic deviceToken;
  String? image;
  dynamic active;
  String? lat;
  String? long;
  int? online;

  User userFromJson(String str) => User.fromJson(json.decode(str));

  String userToJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    lastName: json["last_name"],
    phone: json["phone"],
    email: json["email"],
    deviceToken: json["device_token"],
    image: json["image"],
    active: json["active"],
    lat: json["lat"],
    long: json["long"],
    online: json["online"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "last_name": lastName,
    "phone": phone,
    "email": email,
    "device_token": deviceToken,
    "image": image,
    "active": active,
    "lat": lat,
    "long": long,
    "online": online,
  };
}
