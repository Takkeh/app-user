import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/addresses/my_addresses_ctrl.dart';
import 'package:takkeh/model/restaurants/update_order_model.dart';
import 'package:takkeh/network/restaurants/update_order.dart';
import 'package:takkeh/ui/screens/restaurants/order_status_screen.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';

class UpdateOrderCtrl {
  UpdateOrderModel? model;

  Future fetchUpdateOrderData({
    required int orderId,
    required BuildContext context,
  }) async {
    OverLayLoader.flickrLoading(context);
    model = await UpdateOrderApi().data(orderId: orderId, addressId: MyAddressesCtrl.find.selectedAddressId.value);
    if (model == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (model!.code == 200) {
      Get.to(() => OrderStatusScreen(orderId: model!.order!.id!, route: kHome));
    } else {
      Fluttertoast.showToast(msg: model!.msg!);
    }
    Loader.hide();
  }
}
