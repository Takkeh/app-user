import 'dart:convert';
import 'dart:developer';

import 'package:takkeh/model/wallet/transaction_model.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:http/http.dart' as http;

class MakeTransactionApi {
  static Future<TransactionModel?> data({
    required int walletId,
    required int userId,
    required String type,
    required String amount,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.transaction}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "user_id": userId.toString(),
        "wallet_id": walletId.toString(),
        "type": type,
        "amount": amount,
      });
      log("Response:: MakeTransactionResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("MakeTransactionStatusCode:: ${response.statusCode}  MakeTransactionBody:: ${response.body}");
      TransactionModel model = TransactionModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return model;
      } else {
        throw "MakeTransaction Error";
      }
    } catch (e) {
      log("MakeTransaction Error $e");
      return null;
    }
  }
}
