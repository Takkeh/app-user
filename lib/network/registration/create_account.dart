import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/registration/create_account_model.dart';
import 'package:takkeh/utils/api_url.dart';

class SignUpApi {
  static Future<CreateAccountModel?> data({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.createAccount}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "phone": '+962$phone',
      });
      log("Response:: SignUpResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("SignUpStatusCode:: ${response.statusCode}  SignUpBody:: ${response.body}");
      CreateAccountModel signUpModel = CreateAccountModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return signUpModel;
        //TODO: check status code when email or password is incorrect
      } else if (response.statusCode == 500) {
        return signUpModel;
      } else {
        throw "SignUp Error";
      }
    } catch (e) {
      log("SignUp Error $e");
      return null;
    }
  }
}
