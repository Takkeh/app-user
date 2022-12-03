import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/addresses/create_address_model.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class CreateAddressApi {
  Future<CreateAddressModel?> data({
    required String phone,
    required String name,
    required String region,
    required String street,
    required String buildingNum,
    required String additionalTips,
    required String floor,
    required String apartmentNum,
    required String city,
    required double lat,
    required double lng,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.createAddress}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
      };
      var body = jsonEncode({
        "user_id": MySharedPreferences.userId,
        "lat": lat,
        "long": lng,
        "region": region,
        "street": street,
        "building_number": buildingNum,
        "floor": floor,
        "apartment_number": apartmentNum,
        "additional_tips": additionalTips,
        "city": city,
        "name": name,
        "phone": phone,
      });
      log("Response:: CreateAddressResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("CreateAddressStatusCode:: ${response.statusCode}  CreateAddressBody:: ${response.body}");
      CreateAddressModel model = CreateAddressModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return model;
      } else {
        throw "CreateAddress Error";
      }
    } catch (e) {
      log("CreateAddress Error $e");
      return null;
    }
  }
}
