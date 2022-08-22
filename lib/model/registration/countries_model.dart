class CountriesModel {
  CountriesModel({
    this.status,
    this.code,
    this.msg,
    this.countries,
  });

  CountriesModel.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    countries = json['countries'] != null ? Countries.fromJson(json['countries']) : null;
  }
  bool? status;
  int? code;
  String? msg;
  Countries? countries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['code'] = code;
    map['msg'] = msg;
    if (countries != null) {
      map['countries'] = countries?.toJson();
    }
    return map;
  }
}

class Countries {
  Countries({
    this.af,
    this.ax,
    this.al,
    this.dz,
  });

  Countries.fromJson(dynamic json) {
    af = json['AF'];
    ax = json['AX'];
    al = json['AL'];
    dz = json['DZ'];
  }
  String? af;
  String? ax;
  String? al;
  String? dz;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AF'] = af;
    map['AX'] = ax;
    map['AL'] = al;
    map['DZ'] = dz;
    return map;
  }
}
