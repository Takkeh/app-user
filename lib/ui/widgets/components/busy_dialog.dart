import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';

class BusyDialog {
  void show() {
    Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      titlePadding: EdgeInsets.zero,
      radius: 28,
      contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            TranslationService.getString('restaurant_busy_title_key'),
            style: const TextStyle(
              color: MyColors.redPrimary,
              fontSize: 22,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
            child: Text(
              TranslationService.getString('restaurant_busy_body_key'),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          CustomElevatedButton(
            title: TranslationService.getString('browse_another_restaurant_key'),
            color: MyColors.redPrimary,
            textColor: Colors.white,
            width: 200,
            onPressed: () {
              UserOrderCtrl.find.reset();
              Get.until((route) => Get.currentRoute == AppConstants.restaurantsRouteName);
            },
          ),
        ],
      ),
    );
  }
}
