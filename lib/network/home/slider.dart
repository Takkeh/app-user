import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:takkeh/model/home/slider_model.dart';
import 'package:takkeh/utils/api_url.dart';

class SliderApi {
  static Future<SliderModel?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.slider}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      log("Response:: SliderResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("SliderStatusCode:: ${response.statusCode}  SliderBody:: ${response.body}");
      SliderModel sliderModel = SliderModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return sliderModel;
      } else {
        throw "Slider Error";
      }
    } catch (e) {
      log("Slider Error $e");
      return null;
    }
  }
}
