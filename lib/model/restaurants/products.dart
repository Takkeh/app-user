// To parse this JSON data, do
//
//     final restaurantsModel = restaurantsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel restaurantsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String restaurantsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  ProductsModel({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  List<Product>? products;
  int? total;
  String? skip;
  int? limit;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}

class Product {
  Product({
    this.id,
    this.title,
    this.price,
    this.thumbnail,
    this.rating,
    this.description,
    this.brand,
    this.category,
    this.images,
    this.stock,
    this.discountPercentage,
  });

  int? id;
  String? title;
  int? price;
  String? thumbnail;
  double? rating;
  String? description;
  String? brand;
  String? category;
  List<String>? images;
  int? stock;
  double? discountPercentage;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    thumbnail: json["thumbnail"],
    rating: json["rating"].toDouble(),
    description: json["description"],
    brand: json["brand"],
    category: json["category"],
    images: List<String>.from(json["images"].map((x) => x)),
    stock: json["stock"],
    discountPercentage: json["discountPercentage"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "thumbnail": thumbnail,
    "rating": rating,
    "description": description,
    "brand": brand,
    "category": category,
    "images": List<dynamic>.from(images!.map((x) => x)),
    "stock": stock,
    "discountPercentage": discountPercentage,
  };
}
