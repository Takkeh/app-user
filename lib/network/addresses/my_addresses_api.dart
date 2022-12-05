import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/addresses/my_addresses_model.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class MyAddressesApi {
  Future<MyAddressesModel?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.myAddresses}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
      };
      log("Response:: MyAddressesResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("MyAddressesStatusCode:: ${response.statusCode}  MyAddressesBody:: ${response.body}");
      MyAddressesModel model = MyAddressesModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return model;
      } else {
        throw "MyAddresses Error";
      }
    } catch (e) {
      log("MyAddresses Error $e");
      return null;
    }
  }
}
