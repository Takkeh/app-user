class ViewProductModel {
  ViewProductModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  ViewProductModel.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? status;
  int? code;
  String? msg;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['code'] = code;
    map['msg'] = msg;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.name,
    this.logo,
    this.cover,
    this.time,
    this.products,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    cover = json['cover'];
    time = json['time'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
  }
  int? id;
  String? name;
  String? logo;
  String? cover;
  String? time;
  List<Products>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['logo'] = logo;
    map['cover'] = cover;
    map['time'] = time;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Products {
  Products({
    this.id,
    this.name,
    this.sizes,
    this.extras,
  });

  Products.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    if (json['sizes'] != null) {
      sizes = [];
      json['sizes'].forEach((v) {
        sizes?.add(Sizes.fromJson(v));
      });
    }
    if (json['extras'] != null) {
      extras = [];
      json['extras'].forEach((v) {
        extras?.add(Extras.fromJson(v));
      });
    }
  }
  int? id;
  String? name;
  List<Sizes>? sizes;
  List<Extras>? extras;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (sizes != null) {
      map['sizes'] = sizes?.map((v) => v.toJson()).toList();
    }
    if (extras != null) {
      map['extras'] = extras?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Extras {
  Extras({
    this.id,
    this.price,
    this.name,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  Extras.fromJson(dynamic json) {
    id = json['id'];
    price = json['price'];
    name = json['name'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? price;
  String? name;
  int? productId;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['price'] = price;
    map['name'] = name;
    map['product_id'] = productId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class Sizes {
  Sizes({
    this.id,
    this.price,
    this.name,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  Sizes.fromJson(dynamic json) {
    id = json['id'];
    price = json['price'];
    name = json['name'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? price;
  String? name;
  int? productId;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['price'] = price;
    map['name'] = name;
    map['product_id'] = productId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
