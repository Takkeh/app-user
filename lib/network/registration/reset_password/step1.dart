import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/registration/reset_password/reset_pass_step1_model.dart';
import 'package:takkeh/utils/api_url.dart';

class ResetPassStep1Api {
  static Future<ResetPassStep1Model?> data({
    required String phone,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.resetPassStep1}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "phone": '+962$phone',
      });
      log("Response:: ResetPassStep1Response\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("ResetPassStep1StatusCode:: ${response.statusCode}  ResetPassStep1Body:: ${response.body}");
      ResetPassStep1Model resetPassStep1Model = ResetPassStep1Model.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return resetPassStep1Model;
        //TODO: check status code when email or password is incorrect
      } else if (response.statusCode == 500) {
        return resetPassStep1Model;
      } else {
        throw "ResetPassStep1 Error";
      }
    } catch (e) {
      log("ResetPassStep1 Error $e");
      return null;
    }
  }
}
