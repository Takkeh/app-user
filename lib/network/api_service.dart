import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:takkeh/model/help/faq_list_model.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/shared_prefrences.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<FaqModel?> get({
    required String path,
    required String name,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}$path';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
      };
      log("Response:: ${name}Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("${name}StatusCode:: ${response.statusCode} ${name}Body:: ${response.body}");
      FaqModel model = FaqModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return model;
      } else {
        throw "FAQs Error";
      }
    } on SocketException {
      print('No Internet connection 😑');
    } on HttpException {
      print("Couldn't find the post 😱");
    } on FormatException {
      print("Bad response format 👎");
    }
  }
}
