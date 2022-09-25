import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/controller/user_location.dart';
import 'package:takkeh/model/restaurants/update_order_model.dart';
import 'package:takkeh/utils/api_url.dart';

class UpdateOrderApi {
  static Future<UpdateOrderModel?> data({
    required int orderId,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.updateOrder}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "order_id": orderId,
        "lat": UserLocationCtrl.find.latitude.value.toString(),
        "long": UserLocationCtrl.find.longitude.value.toString(),
      });
      log("Response:: UpdateOrderResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("UpdateOrderStatusCode:: ${response.statusCode}  UpdateOrderBody:: ${response.body}");
      UpdateOrderModel model = UpdateOrderModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return model;
      } else {
        throw "UpdateOrder Error";
      }
    } catch (e) {
      log("UpdateOrder Error $e");
      return null;
    }
  }
}
