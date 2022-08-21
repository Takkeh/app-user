import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/model/registration/log_out_model.dart';
import 'package:takkeh/network/registration/log_out.dart';
import 'package:takkeh/ui/registration/sign_in.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class LogOutController {
  static LogOutModel? logOutModel;

  static Future fetchLogOutData(BuildContext context) async {
    OverLayLoader.showLoading(context);
    logOutModel = await LogOutApi.data();
    if (logOutModel == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (logOutModel!.code == 200) {
      FirebaseAuth.instance.signOut();
      MySharedPreferences.clearProfile();
      Get.offAll(() => const SignInScreen());
    } else {
      Fluttertoast.showToast(msg: logOutModel!.msg!);
    }
    Loader.hide();
  }
}
