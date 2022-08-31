import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/filter_category_model.dart';

class FilterCategoryApi {
  static Future<FilterCategoryModel?> data(int page) async {
    try {
      String url = 'https://dummyjson.com/products?limit=${page}0&skip=${page * 10}&select=title,price,thumbnail,rating,description,brand,category,images,stock,discountPercentage';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      log("Response:: RestaurantsResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("RestaurantsStatusCode:: ${response.statusCode}  RestaurantsBody:: ${response.body}");
      FilterCategoryModel filterCategoryModel = FilterCategoryModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return filterCategoryModel;
      } else {
        throw "Restaurants Error";
      }
    } catch (e) {
      log("Restaurants Error $e");
      return null;
    }
  }
}
