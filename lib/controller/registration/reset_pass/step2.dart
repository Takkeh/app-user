import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/model/registration/reset_password/reset_pass_step2_model.dart';
import 'package:takkeh/network/registration/reset_password/step2.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration/reset_password/step3.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';

class ResetPassStep2Controller extends GetxController {
  // static CheckOtpModel? checkOtpModel;
  static ResetPassStep2Model? resetPassStep2Model;

  static Future fetchResetPassStep2Data({
    required BuildContext context,
    required String phone,
    required String code,
  }) async {
    OverLayLoader.showLoading(context);
    resetPassStep2Model = await ResetPassStep2Api.data(phone: phone, code: code);
    if (resetPassStep2Model == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (resetPassStep2Model!.code == 200) {
      Get.to(() => ResetPassStep3Screen(phone: phone));
    } else if (resetPassStep2Model!.code == 500) {
      Fluttertoast.showToast(msg: TranslationService.getString('incorrect_otp_key'));
    } else {
      Fluttertoast.showToast(msg: resetPassStep2Model!.msg!);
    }
    Loader.hide();
  }
}
