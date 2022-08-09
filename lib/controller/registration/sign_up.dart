import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/nav_bar.dart';
import 'package:takkeh/model/registration/sign_up_model.dart';
import 'package:takkeh/network/registration/sign_up.dart';
import 'package:takkeh/ui/base/nav_bar.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class SignUpController {
  static SignUpModel? signUpModel;

  static Future fetchSignUpData({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    signUpModel = await SignUpApi.data(email: email, password: password, name: name);
    if (signUpModel == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (signUpModel!.code == 200) {
      Get.offAll(() => const BaseNavBar(), binding: NavBarBinding());
      MySharedPreferences.accessToken = signUpModel!.data!.token!;
      MySharedPreferences.email = signUpModel!.data!.user!.email!;
      MySharedPreferences.name = signUpModel!.data!.user!.name!;
      MySharedPreferences.image = signUpModel!.data!.user!.image!;
      MySharedPreferences.phone = signUpModel!.data!.user!.phone!;
      MySharedPreferences.isLogIn = true;
    } else if (signUpModel!.code == 500) {
      //TODO: check status code when email or password is incorrect
      Fluttertoast.showToast(msg: signUpModel!.msg!);
    } else {
      Fluttertoast.showToast(msg: signUpModel!.msg!);
    }
    Loader.hide();
  }
}
