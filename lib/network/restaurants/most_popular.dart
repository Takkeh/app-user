import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/most_popular_model.dart';
import 'package:takkeh/utils/api_url.dart';

class MostPopularApi {
  static Future<MostPopularProductsModel?> data() async {
    try {
      //TODO: change api url
      String url = '${ApiUrl.mainUrl}${ApiUrl.categories}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      log("Response:: RestaurantsResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("RestaurantsStatusCode:: ${response.statusCode}  RestaurantsBody:: ${response.body}");
      MostPopularProductsModel mostPopularModel = MostPopularProductsModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return mostPopularModel;
      } else {
        throw "Restaurants Error";
      }
    } catch (e) {
      log("Restaurants Error $e");
      return null;
    }
  }
}
