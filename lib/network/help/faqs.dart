import 'dart:convert';
import 'dart:developer';
import 'package:takkeh/model/help/faq_list_model.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/shared_prefrences.dart';
import 'package:http/http.dart' as http;

class FAQsApi {
  static Future<FaqModel?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.faq}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
      };
      log("Response:: FAQsResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("FAQsStatusCode:: ${response.statusCode}  FAQsBody:: ${response.body}");
      FaqModel model = FaqModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return model;
      } else {
        throw "FAQs Error";
      }
    } catch (e) {
      log("FAQs Error $e");
      return null;
    }
  }
}
