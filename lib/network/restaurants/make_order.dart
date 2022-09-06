import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/make_order_model.dart';
import 'package:takkeh/utils/api_url.dart';

class MakeOrderApi {
  static Future<MakeOrderModel?> data({
    required List userOrder,
    required int total,
    required int restaurantId,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.makeOrder}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "user_id": 1,
        "restaurant_id": 1,
        "note": "Order Note here",
        "total": 200,
        "products": [
          {
            "product_id": 1,
            "quantity": 5,
            "size_id": 1,
            "extras": [
              {"extra_id": 1}
            ],
            "note": "Product Note",
            "price": 10
          },
          {
            "product_id": 2,
            "quantity": 2,
            "size_id": 4,
            "extras": [
              {"extra_id": 3},
              {"extra_id": 4}
            ],
            "note": "Product Note",
            "price": 10
          }
        ]
      });
      // var body = jsonEncode({
      //   "user_id": MySharedPreferences.userId,
      //   "restaurant_id": restaurantId,
      //   "note": "Order Note here",
      //   "total": total,
      //   "products": userOrder,
      // });
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
