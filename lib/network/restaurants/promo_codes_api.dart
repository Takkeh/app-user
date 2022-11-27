import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/promo_codes_model.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class PromoCodesApi {
  Future<PromoCodesModel?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.promoCodes}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
      };
      log("Response:: PromoCodesResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("PromoCodesStatusCode:: ${response.statusCode}  PromoCodesBody:: ${response.body}");
      PromoCodesModel model = PromoCodesModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return model;
      } else {
        throw "PromoCodes Error";
      }
    } catch (e) {
      log("PromoCodes Error $e");
      return null;
    }
  }
}
