import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/view_product_model.dart';
import 'package:takkeh/utils/api_url.dart';

class ViewRestaurantProductApi {
  static Future<ViewRestaurantProductModel?> data(int id) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.viewRestaurantProduct}$id';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      log("Response:: ViewProductResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("ViewProductStatusCode:: ${response.statusCode}  ViewProductBody:: ${response.body}");
      ViewRestaurantProductModel viewProductModel = ViewRestaurantProductModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return viewProductModel;
      } else {
        throw "ViewProduct Error";
      }
    } catch (e) {
      log("ViewProduct Error $e");
      return null;
    }
  }
}
