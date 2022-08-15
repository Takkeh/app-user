class FilterModel {
  FilterModel({
    this.status,
    this.code,
    this.msg,
    this.categorys,
  });

  FilterModel.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    if (json['Categorys'] != null) {
      categorys = [];
      json['Categorys'].forEach((v) {
        categorys?.add(Categorys.fromJson(v));
      });
    }
  }
  bool? status;
  int? code;
  String? msg;
  List<Categorys>? categorys;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['code'] = code;
    map['msg'] = msg;
    if (categorys != null) {
      map['Categorys'] = categorys?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Categorys {
  Categorys({
    this.id,
    this.name,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  Categorys.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
