import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/registration/verification.dart';
import 'package:takkeh/model/registration/create_account_model.dart';
import 'package:takkeh/network/registration/create_account.dart';
import 'package:takkeh/ui/registration/verification.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/strings.dart';

class CreateAccountController {
  static CreateAccountModel? signUpModel;

  static Future fetchSignUpData({
    required String email,
    required String password,
    required String name,
    required String phone,
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
              ),
          binding: VerificationBinding());
    } else if (signUpModel!.code == 500) {
      Fluttertoast.showToast(msg: MyStrings.emailOrPhoneAlreadyRegisteredKey);
    } else {
      Fluttertoast.showToast(msg: signUpModel!.msg!);
    }
    Loader.hide();
  }
}
