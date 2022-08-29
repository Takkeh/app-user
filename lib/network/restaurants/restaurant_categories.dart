import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/restaurant_categories_model.dart';
import 'package:takkeh/utils/api_url.dart';

class RestaurantCategoriesApi {
  static Future<RestaurantCategoriesModel?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.restaurantCategories}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      log("Response:: RestaurantCategoriesResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("RestaurantCategoriesStatusCode:: ${response.statusCode}  RestaurantCategoriesBody:: ${response.body}");
      RestaurantCategoriesModel restaurantCategoriesModel = RestaurantCategoriesModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return restaurantCategoriesModel;
      } else {
        throw "RestaurantCategories Error";
      }
    } catch (e) {
      log("RestaurantCategories Error $e");
      return null;
    }
  }
}
