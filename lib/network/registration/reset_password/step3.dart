import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/registration/reset_password/reset_pass_step3_model.dart';
import 'package:takkeh/utils/api_url.dart';

class ResetPassStep3Api {
  static Future<ResetPassStep3Model?> data({
    required String phone,
    required String password,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.resetPassStep3}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "phone": '+962$phone',
        "password": password,
      });
      log("Response:: ResetPassStep3Response\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("ResetPassStep3StatusCode:: ${response.statusCode}  ResetPassStep3Body:: ${response.body}");
      ResetPassStep3Model resetPassStep3Model = ResetPassStep3Model.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return resetPassStep3Model;
      } else if (response.statusCode == 500) {
        return resetPassStep3Model;
      } else {
        throw "ResetPassStep3 Error";
      }
    } catch (e) {
      log("ResetPassStep3 Error $e");
      return null;
    }
  }
}
