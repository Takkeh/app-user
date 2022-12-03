import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/basket_binding.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/model/restaurants/make_order_model.dart';
import 'package:takkeh/network/restaurants/make_order.dart';
import 'package:takkeh/ui/screens/restaurants/basket.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';

class MakeOrderCtrl extends GetxController {
  static MakeOrderCtrl get find => Get.find();

  MakeOrderModel? model;
  final orderList = <UserProducts>[].obs;

  Future fetchData({
    required String generalNote,
    required int restaurantId,
    required BuildContext context,
  }) async {
    OverLayLoader.flickrLoading(context);
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
      orderList.value = model!.data!.products!;
      Get.to(
        () => BasketScreen(
          orderId: model!.data!.id!,
          restaurantId: restaurantId,
        ),
        binding: PromoCodesBinding(),
      );
    } else {
      Fluttertoast.showToast(msg: model!.msg!);
    }
    Loader.hide();
  }
}
