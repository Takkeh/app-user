import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/registration/code_timer.dart';
import 'package:takkeh/model/registration/create_account_model.dart';
import 'package:takkeh/network/registration/create_account.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration/verification.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';

class CreateAccountController {
  static CreateAccountModel? signUpModel;

  static Future fetchSignUpData({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String route,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    signUpModel = await SignUpApi.data(email: email, password: password, name: name, phone: phone);
    if (signUpModel == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (signUpModel!.code == 200) {
      Get.to(
          () => VerificationScreen(
                phoneNum: phone,
                name: signUpModel!.data!.user!.name!,
                email: signUpModel!.data!.user!.email!,
                token: signUpModel!.data!.token!,
                userId: signUpModel!.data!.user!.id!,
                route: route,
              ),
          binding: CodeTimerBinding());
    } else if (signUpModel!.code == 500) {
      Fluttertoast.showToast(msg: TranslationService.getString("email_or_phone_already_registered_key"));
    } else {
      Fluttertoast.showToast(msg: signUpModel!.msg!);
    }
    Loader.hide();
  }
}
