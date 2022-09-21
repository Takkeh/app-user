import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/model/restaurants/make_order_model.dart';
import 'package:takkeh/network/restaurants/make_order.dart';
import 'package:takkeh/ui/screens/restaurants/confirm_order.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';

class MakeOrderCtrl {
  static MakeOrderModel? makeOrderModel;

  static Future fetchMakeOrderData({
    required BuildContext context,
    required int restaurantId,
  }) async {
    OverLayLoader.showLoading(context, color: MyColors.redPrimary);
    makeOrderModel = await MakeOrderApi.data(
      userOrder: UserOrderCtrl.find.userOrder,
      total: UserOrderCtrl.find.total.value,
      restaurantId: restaurantId,
    );
    if (makeOrderModel == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (makeOrderModel!.code == 200) {
      Get.to(() => const ConfirmOrderScreen());
    } else {
      Fluttertoast.showToast(msg: makeOrderModel!.msg!);
    }
    Loader.hide();
  }
}
