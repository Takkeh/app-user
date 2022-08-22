import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/registration/countries_model.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class CountriesApi {
  static Future<CountriesModel?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.countries}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': MySharedPreferences.accessToken,
      };
      log("Response:: CountriesResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("CountriesStatusCode:: ${response.statusCode}  CountriesBody:: ${response.body}");
      CountriesModel countriesModel = CountriesModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return countriesModel;
      } else {
        throw "Countries Error";
      }
    } catch (e) {
      log("Countries Error $e");
      return null;
    }
  }
}
