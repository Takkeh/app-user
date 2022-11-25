import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/profile/update_password_model.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class UpdatePasswordApi {
  static Future<UpdatePasswordModel?> data({
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirm,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.updatePassword}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
      };
      var body = jsonEncode({
        "password": oldPassword,
        "new_password": newPassword,
        "new_password_confirmation":newPasswordConfirm,
      });
      log("Response:: UpdatePasswordResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      log("UpdatePasswordStatusCode:: ${response.statusCode}  UpdatePasswordBody:: ${response.body}");
      UpdatePasswordModel updatePasswordModel =
          UpdatePasswordModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return updatePasswordModel;
      } else if (response.statusCode == 500) {
        return updatePasswordModel;
      } else {
        throw "UpdatePassword Error";
      }
    } catch (e) {
      log("UpdatePassword Error $e");
      return null;
    }
  }
}
