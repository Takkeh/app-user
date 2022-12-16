import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/utils/api_url.dart';

class DeviceTokenService {
  static Future<void> updateDeviceToken(String token) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.updateDeviceToken}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        'device_token': token,
      });
      log("Response:: updateDeviceTokenResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("updateDeviceTokenStatusCode:: ${response.statusCode} updateTokenBody:: ${response.body}");
    } catch (e) {
      log("deviceTokenError:: $e");
    }
  }
}
