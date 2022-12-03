import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/registration/sign_in.dart';
import 'package:takkeh/helper/guest_user_helper.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration/registration.dart';
import 'package:takkeh/ui/widgets/back_leading_widget.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';

class GuestDialog {
  static Future<void> show(String routeName) async {
    Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      titlePadding: EdgeInsets.zero,
      radius: 28,
      contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20.0),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const BackLeadingWidget(icon: Icons.close),
              Flexible(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8.0),
                  child: Text(
                    TranslationService.getString('guest_dialog_title_key'),
                    style: const TextStyle(
                      color: MyColors.redPrimary,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
            child: Text(
              TranslationService.getString('guest_dialog_body_key'),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  title: TranslationService.getString('cancel_key'),
                  color: MyColors.redPrimary,
                  textColor: Colors.white,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: CustomElevatedButton(
                  title: TranslationService.getString('sign_in_key'),
                  color: MyColors.redPrimary,
                  textColor: Colors.white,
                  onPressed: () {
                    Get.back();
                    GuestUserHelper.currentRoute = routeName;
                    log("currentRoute:: ${GuestUserHelper.currentRoute}");
                    Get.to(() => const RegistrationScreen(route: kBack), binding: RegistrationBinding());
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
