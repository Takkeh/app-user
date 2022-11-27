import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/restaurants_model.dart';
import 'package:takkeh/utils/api_url.dart';

class RestaurantsApi {
  static Future<RestaurantsModel?> data({
    required int tagId,
    required int categoryId,
    required int pageKey,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.restaurants}?page=$pageKey';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "category_id": categoryId,
        "tag_id": tagId,
      });
      log("Response:: RestaurantsResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("RestaurantsStatusCode:: ${response.statusCode}  RestaurantsBody:: ${response.body}");
      RestaurantsModel model = RestaurantsModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return model;
      } else {
        throw "Restaurants Error";
      }
    } catch (e) {
      log("Restaurants Error $e");
      return null;
    }
  }
}
