import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/restaurants_model.dart';
import 'package:takkeh/utils/api_url.dart';

class RestaurantsSearchApi {
  static Future<RestaurantsModel?> data({
    required String query,
    required int pageKey,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.restaurantsSearch}?page=$pageKey';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        'keyword': query,
      });
      log("Response:: RestaurantsSearchResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("RestaurantsSearchStatusCode:: ${response.statusCode}  RestaurantsSearchBody:: ${response.body}");
      RestaurantsModel model = RestaurantsModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return model;
      } else {
        throw "RestaurantsSearch Error";
      }
    } catch (e) {
      log("RestaurantsSearch Error $e");
      return null;
    }
  }
}
