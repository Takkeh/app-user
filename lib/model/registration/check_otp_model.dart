class CheckOtpModel {
  CheckOtpModel({
    this.status,
    this.code,
    this.msg,
  });

  CheckOtpModel.fromJson(dynamic json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
  }
  bool? status;
  int? code;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['code'] = code;
    map['msg'] = msg;
    return map;
  }
}
