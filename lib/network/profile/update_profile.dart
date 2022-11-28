import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:takkeh/model/profile/update_profile_model.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/shared_prefrences.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UpdateProfileApi {
  static Future<UpdateProfileModel?> dataWithImage({
    required String name,
    required String email,
    required File? image,
  }) async {
    try {
      MultipartFile? multipartFile;
      if (image != null) {
        var stream = http.ByteStream(image.openRead());
        var length = await image.length();
        multipartFile = http.MultipartFile("image", stream, length,
            filename: basename(image.path));
      }
      var uri = Uri.parse("${ApiUrl.mainUrl}${ApiUrl.updateProfile}");
      var request = http.MultipartRequest("POST", uri);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
      };
      request.headers.addAll(headers);
      if (image != null) request.files.add(multipartFile!);
      request.fields['name'] = name;
      request.fields['email'] = email;
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        var jsonData = jsonDecode(responseString);
        UpdateProfileModel updateProfileModel =
        UpdateProfileModel.fromJson(jsonData);
        return updateProfileModel;
      } else {
        throw "UpdateProfile Error";
      }
    } catch (e) {
      log("UpdateProfile Error $e");
      return null;
    }
  }
}
