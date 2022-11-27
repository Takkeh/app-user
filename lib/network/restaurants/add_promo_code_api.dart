import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/add_promo_code_model.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class AddPromoCodeApi {
  Future<AddPromoCodeModel?> data({
    required int orderId,
    required int promoId,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.addPromoCode}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
      };
      var body = jsonEncode({
        "order_id": orderId,
        "code_id": promoId,
      });
      log("Response:: AddPromoCodeResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("AddPromoCodeStatusCode:: ${response.statusCode}  AddPromoCodeBody:: ${response.body}");
      AddPromoCodeModel model = AddPromoCodeModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return model;
      } else if (response.statusCode == 500) {
        return model;
      } else {
        throw "AddPromoCode Error";
      }
    } catch (e) {
      log("AddPromoCode Error $e");
      return null;
    }
  }
}
