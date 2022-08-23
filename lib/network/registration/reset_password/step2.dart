import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/registration/reset_password/reset_pass_step2_model.dart';
import 'package:takkeh/utils/api_url.dart';

class ResetPassStep2Api {
  static Future<ResetPassStep2Model?> data({
    required String phone,
    required String code,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.resetPassStep2}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "phone": '+962$phone',
        "code": code,
      });
      log("Response:: ResetPassStep2Response\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("ResetPassStep2StatusCode:: ${response.statusCode}  ResetPassStep2Body:: ${response.body}");
      ResetPassStep2Model resetPassStep2Model = ResetPassStep2Model.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return resetPassStep2Model;
      } else if (response.statusCode == 500) {
        return resetPassStep2Model;
      } else {
        throw "ResetPassStep2 Error";
      }
    } catch (e) {
      log("ResetPassStep2 Error $e");
      return null;
    }
  }
}
