import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/restaurants_model.dart';

class RestaurantsApi {
  static Future<RestaurantsModel?> data() async {
    try {
      String url = 'http://api.brightlifeapp.com/public/api/v1/categories';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      log("Response:: RestaurantsResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("RestaurantsStatusCode:: ${response.statusCode}  RestaurantsBody:: ${response.body}");
      RestaurantsModel restaurantsModel = RestaurantsModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return restaurantsModel;
      } else {
        throw "Restaurants Error";
      }
    } catch (e) {
      log("Restaurants Error $e");
      return null;
    }
  }
}
