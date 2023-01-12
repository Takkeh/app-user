import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:takkeh/binding/restaurants/basket_binding.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/model/restaurants/make_order_model.dart';
import 'package:takkeh/network/restaurants/make_order.dart';
import 'package:takkeh/ui/screens/restaurants/basket.dart';
import 'package:takkeh/ui/screens/restaurants/confirm_order.dart';
import 'package:takkeh/ui/widgets/components/base_dialog.dart';
import 'package:takkeh/ui/widgets/components/busy_dialog.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';

class MakeOrderCtrl extends GetxController {
  static MakeOrderCtrl get find => Get.find();

  MakeOrderModel? model;
  final orderList = <UserProducts>[].obs;

  void showLoading() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..maskType = EasyLoadingMaskType.custom
      ..indicatorColor = Colors.transparent
      ..textColor = Colors.transparent
      ..maskColor = Colors.black26
      ..backgroundColor = Colors.transparent
      ..boxShadow = [];
    EasyLoading.show(
      indicator: LoadingAnimationWidget.flickr(
        leftDotColor: MyColors.text,
        rightDotColor: MyColors.redPrimary,
        size: 50,
      ),
    );
  }

  Future fetchData({
    required String generalNote,
    required int restaurantId,
    required BuildContext context,
    required String route,
  }) async {
    showLoading();
    model = await MakeOrderApi.data(
      userOrder: UserOrderCtrl.find.orderList,
      generalNote: generalNote,
      totalPrice: UserOrderCtrl.find.totalPrice.value,
      restaurantsId: restaurantId,
    );
    if (model == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (model!.code == 200) {
      EasyLoading.dismiss();
      orderList.value = model!.data!.products!;
      var orderId = model!.data!.id!;
      if (model!.data!.isBusy == 1) {
        BusyDialog().show();
        return;
      }
      if (route == kBasket) {
        Get.to(
          () => BasketScreen(
            orderId: orderId,
            restaurantId: restaurantId,
          ),
          binding: PromoCodesBinding(),
        );
      }
      if (route == kConfirm) {
        Get.to(() => ConfirmOrderScreen(orderId: orderId));
      }
    } else {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: model!.msg!);
    }
  }
}
