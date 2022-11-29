import 'dart:convert';

class TransactionModel {
  TransactionModel({
    this.status,
    this.code,
    this.msg,
    this.transaction,
  });

  bool? status;
  int? code;
  String? msg;
  Transaction? transaction;

  TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

  String transactionModelToJson() => json.encode(toJson());

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    status: json["status"],
    code: json["code"],
    msg: json["msg"],
    transaction: Transaction.fromJson(json["Transaction"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "msg": msg,
    "Transaction": transaction!.toJson(),
  };
}

class Transaction {
  Transaction({
    this.id,
    this.type,
    this.status,
    this.amount,
    this.walletId,
    this.walletName,
    this.walletTotal,
    this.user,
  });

  int? id;
  String? type;
  String? status;
  String? amount;
  String? walletId;
  String? walletName;
  int? walletTotal;
  User? user;

  Transaction transactionFromJson(String str) => Transaction.fromJson(json.decode(str));

  String transactionToJson() => json.encode(toJson());

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"],
    type: json["type"],
    status: json["status"],
    amount: json["amount"],
    walletId: json["wallet_id"],
    walletName: json["wallet_name"],
    walletTotal: json["wallet_total"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "status": status,
    "amount": amount,
    "wallet_id": walletId,
    "wallet_name": walletName,
    "wallet_total": walletTotal,
    "user": user!.toJson(),
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
  });

  int? id;
  String? name;
  String? lastName;
  String? phone;
  String? email;
  dynamic deviceToken;
  String? image;

  User userFromJson(String str) => User.fromJson(json.decode(str));

  String userToJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"]??'',
    lastName: json["last_name"]??'',
    phone: json["phone"]??'',
    email: json["email"]??'',
    deviceToken: json["device_token"]??'',
    image: json["image"]??'',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "last_name": lastName,
    "phone": phone,
    "email": email,
    "device_token": deviceToken,
    "image": image,
  };
}
