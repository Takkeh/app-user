import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/view_restaurant.dart';
import 'package:takkeh/utils/api_url.dart';

class ViewRestaurantApi {
  static Future<ViewRestaurantModel?> data(int id) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.viewRestaurants}$id';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      log("Response:: ViewRestaurantsResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("ViewRestaurantsStatusCode:: ${response.statusCode}  ViewRestaurantsBody:: ${response.body}");
      ViewRestaurantModel viewRestaurantModel = ViewRestaurantModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return viewRestaurantModel;
      } else {
        throw "ViewRestaurants Error";
      }
    } catch (e) {
      log("ViewRestaurants Error $e");
      return null;
    }
  }
}
