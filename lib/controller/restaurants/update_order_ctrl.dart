import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/update_order_model.dart';
import 'package:takkeh/network/restaurants/update_order.dart';
import 'package:takkeh/ui/screens/restaurants/order_status.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';

class UpdateOrderCtrl {
  static UpdateOrderModel? model;

  static Future fetchUpdateOrderData({
    required int orderId,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context, color: MyColors.redPrimary);
    model = await UpdateOrderApi.data(orderId: orderId);
    if (model == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (model!.code == 200) {
      Get.to(() => OrderStatusScreen(orderId: model!.data!.id!));
    } else {
      Fluttertoast.showToast(msg: model!.msg!);
    }
    Loader.hide();
  }
}
