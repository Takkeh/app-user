import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:takkeh/binding/nav_bar.dart';
import 'package:takkeh/controller/addresses/my_addresses_ctrl.dart';
import 'package:takkeh/helper/guest_user_helper.dart';
import 'package:takkeh/model/registration/social_sign_in_model.dart';
import 'package:takkeh/network/registration/socail_sign_in_api.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/base/nav_bar.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class SocialSignInController extends GetxController {
  static SocialSignInController get find => Get.find();

  SocialSignInModel? model;

  Future signInWithGoogle(BuildContext context, {required String route}) async {
    try {
      OverLayLoader.showLoading(context);
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleAuth?.accessToken == null) {
        Loader.hide();
        return;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        fetchSignInData(email: value.user!.email!, username: value.user!.displayName!, context: context, route: route);
      }).catchError((onError) {
        if (onError.toString() == AppConstants.differentCredentialMessage) {
          log("FirebaseAuthException:: $onError");
          fetchSignInData(email: onError.email!, username: onError.displayName!, context: context, route: route);
        } else {
          log("FirebaseAuthException:: $onError");
          Loader.hide();
          Fluttertoast.showToast(msg: "$onError");
        }
      });
    } catch (e) {
      log("FirebaseAuthException:: $e");
      Loader.hide();
      Fluttertoast.showToast(msg: "$e");
    }
  }

  Future fetchSignInData({
    required String email,
    required String username,
    required String route,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    model = await SocialSignInApi().data(email: email, username: username);
    if (model == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (model!.code == 200) {
      MySharedPreferences.accessToken = model!.data!.token!;
      MySharedPreferences.email = model!.data!.user!.email!;
      MySharedPreferences.name = model!.data!.user!.name!;
      MySharedPreferences.userId = model!.data!.user!.id!;
      MySharedPreferences.image = model!.data!.user!.image!;
      MySharedPreferences.phone = model!.data!.user!.phone!;
      MySharedPreferences.isLogIn = true;
      log("route:: $route");
      if (route == kHome) {
        Get.offAll(() => const BaseNavBar(), binding: NavBarBinding());
      }
      if (route == kBack) {
        await MyAddressesCtrl.find.fetchData();
        Get.until((route) => Get.currentRoute == GuestUserHelper.currentRoute);
      }
    } else if (model!.code == 500) {
      Fluttertoast.showToast(msg: TranslationService.getString('incorrect_email_or_password_key'));
    } else {
      Fluttertoast.showToast(msg: model!.msg!);
    }
    Loader.hide();
  }
}
