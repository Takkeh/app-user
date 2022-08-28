import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/registration/code_timer.dart';
import 'package:takkeh/model/registration/reset_password/reset_pass_step1_model.dart';
import 'package:takkeh/network/registration/reset_password/step1.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/registration/reset_password/step2.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';

class ResetPassStep1Controller {
  static ResetPassStep1Model? resetPassStep1Model;

  static Future fetchOtpData({
    required BuildContext context,
    required String phone,
  }) async {
    OverLayLoader.showLoading(context);
    resetPassStep1Model = await ResetPassStep1Api.data(phone: phone);
    if (resetPassStep1Model == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (resetPassStep1Model!.code == 200) {
      Get.to(() => ResetPassStep2Screen(phoneNum: phone), binding: CodeTimerBinding());
    } else if (resetPassStep1Model!.code == 500) {
      Fluttertoast.showToast(msg: TranslationService.getString('wrong_otp_key'));
    } else {
      Fluttertoast.showToast(msg: resetPassStep1Model!.msg!);
    }
    Loader.hide();
  }
}
