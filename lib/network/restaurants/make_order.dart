import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/make_order_model.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class MakeOrderApi {
  static Future<MakeOrderModel?> data({
    required List<Map<String, dynamic>> userOrder,
    required String generalNote,
    required double totalPrice,
    required int restaurantsId,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.makeOrder}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': MySharedPreferences.accessToken,
      };
      var body = jsonEncode({
        "user_id": MySharedPreferences.userId,
        "note": generalNote,
        "total": totalPrice,
        "restaurant_id": restaurantsId,
        "products": userOrder,
      });
      log("Response:: MakeOrderResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("MakeOrderStatusCode:: ${response.statusCode}  MakeOrderBody:: ${response.body}");
      MakeOrderModel makeOrderModel = MakeOrderModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return makeOrderModel;
      } else {
        throw "MakeOrder Error";
      }
    } catch (e) {
      log("MakeOrder Error $e");
      return null;
    }
  }
}
