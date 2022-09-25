import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/restaurants_search_model.dart';
import 'package:takkeh/utils/api_url.dart';

class RestaurantsSearchApi {
  static Future<RestaurantsSearchModel?> data({
    required String query,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.restaurantsSearch}$query';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({});
      log("Response:: RestaurantsSearchResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("RestaurantsSearchStatusCode:: ${response.statusCode}  RestaurantsSearchBody:: ${response.body}");
      RestaurantsSearchModel model = RestaurantsSearchModel.fromJson(json.decode(response.body));
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
