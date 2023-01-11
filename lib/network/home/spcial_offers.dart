import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/home/offers_model.dart';
import 'package:takkeh/utils/api_url.dart';

class SpecialOffersApi {
  static Future<OffersModel?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.specialOffers}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      log("Response:: SpecialOffersResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("SpecialOffersStatusCode:: ${response.statusCode}  SpecialOffersBody:: ${response.body}");
      OffersModel specialOffersModel = OffersModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return specialOffersModel;
      } else {
        throw "SpecialOffers Error";
      }
    } catch (e) {
      log("SpecialOffers Error $e");
      return null;
    }
  }
}
