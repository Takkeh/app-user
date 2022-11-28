import 'dart:convert';
import 'dart:developer';
import 'package:takkeh/model/wallet/wallet_view_model.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/shared_prefrences.dart';
import 'package:http/http.dart' as http;

class WalletApi {
  static Future<WalletViewModel?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.walletView}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
      };
      log("Response:: WalletResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("WalletStatusCode:: ${response.statusCode}  WalletBody:: ${response.body}");
      WalletViewModel model = WalletViewModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return model;
      } else {
        throw "Wallet Error";
      }
    } catch (e) {
      log("Wallet Error $e");
      return null;
    }
  }
}
