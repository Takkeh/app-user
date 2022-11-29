import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/restaurant_info_model.dart';
import 'package:takkeh/utils/api_url.dart';

class RestaurantInfoApi {
  static Future<RestaurantInfoModel?> data({
    required int id,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.restaurantInfo}$id';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      log("Response:: RestaurantInfoResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("RestaurantInfoStatusCode:: ${response.statusCode}  RestaurantInfoBody:: ${response.body}");
      RestaurantInfoModel model = RestaurantInfoModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return model;
      } else {
        throw "RestaurantInfo Error";
      }
    } catch (e) {
      log("RestaurantInfo Error $e");
      return null;
    }
  }
}
