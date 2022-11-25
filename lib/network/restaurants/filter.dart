import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/restaurants/filter_model.dart';
import 'package:takkeh/utils/api_url.dart';

class FilterApi {
  static Future<FilterModel?> data() async {
    try {
      //TODO: change later to another url
      String url = '${ApiUrl.mainUrl}${ApiUrl.offers}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      log("Response:: FilterResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("FilterStatusCode:: ${response.statusCode}  FilterBody:: ${response.body}");
      FilterModel filterModel = FilterModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return filterModel;
      } else {
        throw "Filter Error";
      }
    } catch (e) {
      log("Filter Error $e");
      return null;
    }
  }
}
