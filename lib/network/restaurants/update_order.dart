import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/update_order_model.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class UpdateOrderApi {
  Future<UpdateOrderModel?> data({
    required int orderId,
    required int addressId,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.updateOrder}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
      };
      var body = jsonEncode({
        "order_id": orderId,
        "address_id": addressId,
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
