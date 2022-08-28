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
  });

  Offers.fromJson(dynamic json) {
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
