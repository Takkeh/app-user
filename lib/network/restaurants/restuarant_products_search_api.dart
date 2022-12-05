import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/restaurants_products_search_model.dart';
import 'package:takkeh/utils/api_url.dart';

class RestaurantProductsSearchApi {
  Future<RestaurantProductsSearchModel?> data({
    required String query,
    required int restaurantsId,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.restaurantProductsSearch}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        'key': query,
        'restaurant_id': restaurantsId,
      });
      log("Response:: RestaurantProductsSearchResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("RestaurantProductsSearchStatusCode:: ${response.statusCode}  RestaurantProductsSearchBody:: ${response.body}");
      RestaurantProductsSearchModel model = RestaurantProductsSearchModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return model;
      } else {
        throw "RestaurantProductsSearch Error";
      }
    } catch (e) {
      log("RestaurantProductsSearch Error $e");
      return null;
    }
  }
}
