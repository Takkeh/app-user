import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/model/registration/reset_password/reset_pass_step3_model.dart';
import 'package:takkeh/network/registration/reset_password/step3.dart';
import 'package:takkeh/ui/registration/registration.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';

class ResetPassStep3Controller extends GetxController {
  final isPasswordObscure = true.obs;
  final isConfirmPasswordObscure = true.obs;
  static ResetPassStep3Model? resetPassStep3Model;

  void changePasswordObscure() {
    isPasswordObscure.value = !isPasswordObscure.value;
    update();
  }

  void changeConfirmPasswordObscure() {
    isConfirmPasswordObscure.value = !isConfirmPasswordObscure.value;
    update();
  }

  static Future fetchResetPassStep3Data({
    required BuildContext context,
    required String phone,
    required String password,
  }) async {
    OverLayLoader.showLoading(context);
    resetPassStep3Model = await ResetPassStep3Api.data(phone: phone, password: password);
    if (resetPassStep3Model == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (resetPassStep3Model!.code == 200) {
      Fluttertoast.showToast(msg: "password changed successfully");
      Get.offAll(() => const RegistrationScreen());
    } else if (resetPassStep3Model!.code == 500) {
      Fluttertoast.showToast(msg: "incorrect otp");
    } else {
      Fluttertoast.showToast(msg: resetPassStep3Model!.msg!);
    }
    Loader.hide();
  }
}
