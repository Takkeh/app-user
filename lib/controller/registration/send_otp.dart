import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/nav_bar.dart';
import 'package:takkeh/controller/addresses/my_addresses_ctrl.dart';
import 'package:takkeh/helper/guest_user_helper.dart';
import 'package:takkeh/model/registration/send_otp_model.dart';
import 'package:takkeh/network/registration/send_otp.dart';
import 'package:takkeh/ui/base/nav_bar.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class SendOtpController {
  static SendOtpModel? checkOtpModel;

  static Future fetchOtpData({
    required BuildContext context,
    required String phone,
    required String name,
    required int userId,
    required String token,
    required String email,
    required String code,
    required String route,
  }) async {
    OverLayLoader.showLoading(context);
    checkOtpModel = await SendOtpApi.data(phone: phone, code: code);
    if (checkOtpModel == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (checkOtpModel!.code == 200) {
      MySharedPreferences.accessToken = token;
      MySharedPreferences.email = email;
      MySharedPreferences.name = name;
      MySharedPreferences.userId = userId;
      MySharedPreferences.phone = "+962$phone";
      MySharedPreferences.isLogIn = true;
      if (route == kHome) {
        Get.offAll(() => const BaseNavBar(), binding: NavBarBinding());
      }
      if (route == kBack) {
        await MyAddressesCtrl.find.fetchData();
        Get.until((route) => Get.currentRoute == GuestUserHelper.currentRoute);
      }
    } else if (checkOtpModel!.code == 500) {
      Fluttertoast.showToast(msg: "incorrect otp");
    } else {
      Fluttertoast.showToast(msg: checkOtpModel!.msg!);
    }
    Loader.hide();
  }
}
