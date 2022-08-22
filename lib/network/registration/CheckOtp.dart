import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/registration/check_otp_model.dart';
import 'package:takkeh/utils/api_url.dart';

class CheckOtpApi {
  static Future<CheckOtpModel?> data({
    required String phone,
    required String code,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.checkOtp}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "code": code,
        "phone": '+962$phone',
      });
      log("Response:: CheckOtpResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("CheckOtpStatusCode:: ${response.statusCode}  CheckOtpBody:: ${response.body}");
      CheckOtpModel checkOtpModel = CheckOtpModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return checkOtpModel;
        //TODO: check status code when email or password is incorrect
      } else if (response.statusCode == 500) {
        return checkOtpModel;
      } else {
        throw "CheckOtp Error";
      }
    } catch (e) {
      log("CheckOtp Error $e");
      return null;
    }
  }
}
