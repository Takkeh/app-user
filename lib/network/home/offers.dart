import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/home/offers_model.dart';
import 'package:takkeh/utils/api_url.dart';

class OffersApi {
  static Future<OffersModel?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.offers}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      log("Response:: OffersResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("OffersStatusCode:: ${response.statusCode}  OffersBody:: ${response.body}");
      OffersModel offersModel = OffersModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return offersModel;
      } else {
        throw "Offers Error";
      }
    } catch (e) {
      log("Offers Error $e");
      return null;
    }
  }
}
