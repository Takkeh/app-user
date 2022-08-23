import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/home/categories_model.dart';

class CategoriesApi {
  static Future<CategoriesModel?> data() async {
    try {
      String url = 'http://api.brightlifeapp.com/public/api/v1/categories';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      log("Response:: CategoriesResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("CategoriesStatusCode:: ${response.statusCode}  CategoriesBody:: ${response.body}");
      CategoriesModel categoriesModel = CategoriesModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return categoriesModel;
      } else {
        throw "Categories Error";
      }
    } catch (e) {
      log("Categories Error $e");
      return null;
    }
  }
}
