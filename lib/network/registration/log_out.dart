import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/registration/log_out_model.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class LogOutApi {
  static Future<LogOutModel?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.logOut}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
      };
      log("Response:: LogOutResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("LogOutStatusCode:: ${response.statusCode}  LogOutBody:: ${response.body}");
      LogOutModel logOutModel = LogOutModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return logOutModel;
      } else if (response.statusCode == 500) {
        return logOutModel;
      } else {
        throw "LogOut Error";
      }
    } catch (e) {
      log("LogOut Error $e");
      return null;
    }
  }
}
