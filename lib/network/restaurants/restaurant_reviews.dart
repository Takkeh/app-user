import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/restaurant_info_model.dart';
import 'package:takkeh/utils/api_url.dart';

class RestaurantReviewsApi {
  static Future<RestaurantInfoModel?> data({
    required int id,
    required int pageKey,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.restaurantReviews}$id?page=$pageKey';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      log("Response:: RestaurantReviewsResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("RestaurantReviewsStatusCode:: ${response.statusCode}  RestaurantReviewsBody:: ${response.body}");
      RestaurantInfoModel model = RestaurantInfoModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return model;
      } else {
        throw "RestaurantReviews Error";
      }
    } catch (e) {
      log("RestaurantReviews Error $e");
      return null;
    }
  }
}
