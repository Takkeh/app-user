import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/my_orders/my_orders_model.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class MyOrdersApi {
  static Future<MyOrdersModel?> data({
    required int pageKey,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.myOrders}?page=$pageKey';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
      };
      log("Response:: MyOrdersResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("MyOrdersStatusCode:: ${response.statusCode}  MyOrdersBody:: ${response.body}");
      MyOrdersModel model = MyOrdersModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return model;
      } else {
        throw "MyOrders Error";
      }
    } catch (e) {
      log("MyOrders Error $e");
      return null;
    }
  }
}
