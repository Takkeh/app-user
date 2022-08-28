import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/nav_bar.dart';
import 'package:takkeh/model/registration/sign_in_model.dart';
import 'package:takkeh/network/registration/sign_in.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/base/nav_bar.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class SignInController extends GetxController {
  static SignInController get find => Get.find();

  SignInModel? signInModel;
  final isObscure = true.obs;

  void changeObscure() {
    isObscure.value = !isObscure.value;
    update();
  }

  Future fetchSignInData({
    required String phone,
    required String password,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    signInModel = await SignInApi.data(phone: phone, password: password);
    if (signInModel == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (signInModel!.code == 200) {
      Get.offAll(() => const BaseNavBar(), binding: NavBarBinding());
      MySharedPreferences.accessToken = signInModel!.data!.token!;
      MySharedPreferences.email = signInModel!.data!.user!.email!;
      MySharedPreferences.name = signInModel!.data!.user!.name!;
      MySharedPreferences.image = signInModel!.data!.user!.image!;
      MySharedPreferences.phone = signInModel!.data!.user!.phone!;
      MySharedPreferences.isLogIn = true;
    } else if (signInModel!.code == 500) {
      Fluttertoast.showToast(msg: TranslationService.getString('incorrect_email_or_password_key'));
    } else {
      Fluttertoast.showToast(msg: signInModel!.msg!);
    }
    Loader.hide();
  }
}
