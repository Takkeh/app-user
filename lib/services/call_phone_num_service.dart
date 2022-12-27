import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:takkeh/utils/app_constants.dart';

import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class CallPhoneNumService {
  Future<void> init(String phone) async {
    try {
      var link = Platform.isAndroid ? "tel:$phone" : "tel://$phone";
      final Uri url = Uri.parse(link);
      await launchUrl(url);
    } catch (e) {
      log("error:: $e");
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
    }
  }
}