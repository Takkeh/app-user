class SpecialOffersModel {
  SpecialOffersModel({
    this.status,
    this.code,
    this.msg,
    this.specials,
  });

  SpecialOffersModel.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    if (json['Specials'] != null) {
      specials = [];
      json['Specials'].forEach((v) {
        specials?.add(Specials.fromJson(v));
      });
    }
  }
  bool? status;
  int? code;
  String? msg;
  List<Specials>? specials;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['code'] = code;
    map['msg'] = msg;
    if (specials != null) {
      map['Specials'] = specials?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Specials {
  Specials({
    this.id,
    this.image,
  });

  Specials.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
  }
  int? id;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    return map;
  }
}
