import 'dart:convert';

class WalletViewModel {
  WalletViewModel({
    this.status,
    this.code,
    this.msg,
    this.myWallet,
  });

  bool? status;
  int? code;
  String? msg;
  MyWallet? myWallet;

  WalletViewModel walletViewModelFromJson(String str) => WalletViewModel.fromJson(json.decode(str));

  String walletViewModelToJson() => json.encode(toJson());

  factory WalletViewModel.fromJson(Map<String, dynamic> json) => WalletViewModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        myWallet: MyWallet.fromJson(json["my_wallet"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "my_wallet": myWallet!.toJson(),
      };
}

class MyWallet {
  MyWallet({
    this.id,
    this.name,
    this.total,
    this.user,
    this.transactions,
  });

  int? id;
  String? name;
  int? total;
  User? user;
  List<Transaction>? transactions;

  MyWallet myWalletFromJson(String str) => MyWallet.fromJson(json.decode(str));

  String myWalletToJson() => json.encode(toJson());

  factory MyWallet.fromJson(Map<String, dynamic> json) => MyWallet(
        id: json["id"],
        name: json["name"],
        total: json["total"],
        user: User.fromJson(json["user"]),
        transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "total": total,
        "user": user!.toJson(),
        "transactions": List<dynamic>.from(transactions!.map((x) => x.toJson())),
      };
}

class Transaction {
  Transaction({
    this.id,
    this.type,
    this.status,
    this.amount,
  });

  int? id;
  String? type;
  String? status;
  int? amount;

  Transaction transactionFromJson(String str) => Transaction.fromJson(json.decode(str));

  String transactionToJson() => json.encode(toJson());

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        type: json["type"],
        status: json["status"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "status": status,
        "amount": amount,
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
        name: json["name"],
        lastName: json["last_name"],
        phone: json["phone"] == null ? '' : json["phone"].toString(),
        email: json["email"],
        deviceToken: json["device_token"],
        image: json["image"],
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
