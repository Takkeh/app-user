class SliderModel {
  SliderModel({
    this.status,
    this.code,
    this.msg,
    this.sliders,
  });

  SliderModel.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    if (json['Sliders'] != null) {
      sliders = [];
      json['Sliders'].forEach((v) {
        sliders?.add(Sliders.fromJson(v));
      });
    }
  }
  bool? status;
  int? code;
  String? msg;
  List<Sliders>? sliders;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['code'] = code;
    map['msg'] = msg;
    if (sliders != null) {
      map['Sliders'] = sliders?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Sliders {
  Sliders({
    this.id,
    this.image,
  });

  Sliders.fromJson(dynamic json) {
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
