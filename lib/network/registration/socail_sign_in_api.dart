import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/registration/social_sign_in_model.dart';
import 'package:takkeh/utils/api_url.dart';

class SocialSignInApi {
  Future<SocialSignInModel?> data({
    required String email,
    required String username,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.socialSignIn}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "email": email,
        "username": username,
        "type": 'user',
      });
      log("Response:: SocialSignInResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("SocialSignInStatusCode:: ${response.statusCode}  SocialSignInBody:: ${response.body}");
      SocialSignInModel model = SocialSignInModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return model;
      } else {
        throw "SocialSignIn Error";
      }
    } catch (e) {
      log("SocialSignIn Error $e");
      return null;
    }
  }
}
