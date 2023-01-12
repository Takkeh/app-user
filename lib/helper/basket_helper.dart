import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/make_order.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/helper/guest_user_helper.dart';
import 'package:takkeh/helper/location_permission_helper.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';

class BasketHelper {
  static void toggle(
    BuildContext context, {
    required int restaurantId,
    required String surfaceType,
  }) {
    if (GuestUserHelper.check(Get.currentRoute, context)) {
      LocationPermissionHelper.check(
        action: () {
          if (UserOrderCtrl.find.orderList.isEmpty) {
            if (surfaceType == kFloatSnackBar) {
              Get.closeCurrentSnackbar();
              Get.snackbar(
                '',
                TranslationService.getString('your_basket_is_empty_key'),
                titleText: const SizedBox.shrink(),
                colorText: Colors.white,
                margin: const EdgeInsets.all(10.0),
                backgroundColor: MyColors.redPrimary,
              );
            }
            if (surfaceType == kRawSnackBar) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(TranslationService.getString('your_basket_is_empty_key')),
                ),
              );
            }
            return;
          }
          MakeOrderCtrl.find.fetchData(
            context: context,
            restaurantId: restaurantId,
            generalNote: '',
            route: kBasket,
          );
        },
      );
    }
  }
}
