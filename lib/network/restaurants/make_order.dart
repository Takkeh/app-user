import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/make_order_model.dart';
import 'package:takkeh/utils/api_url.dart';

class MakeOrderApi {
  static Future<MakeOrderModel?> data({
    required List userOrder,
    required double total,
    required String generalNote,
    required int restaurantId,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.makeOrder}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        //TODO: from shared pref
        "user_id": 1,
        "restaurant_id": restaurantId,
        "note": generalNote,
        "total": total,
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
