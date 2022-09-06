import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/make_order_model.dart';
import 'package:takkeh/network/restaurants/make_order.dart';
import 'package:takkeh/ui/screens/restaurants/basket.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';

class UserOrderCtrl extends GetxController {
  static UserOrderCtrl get find => Get.find();
  final userOrder = <Map<String, dynamic>>[].obs;
  MakeOrderModel? makeOrderModel;

  // final reOrderedUserOrder = <Map<String, dynamic>>[].obs;

  // final alaa = {
  //   'userID': 1,
  //   'products': [
  //     {
  //       'productId': productId,
  //       'quantity': quantity,
  //       'chose': choose,
  //       'extra': extras,
  //       'note': note,
  //       'price': price,
  //     },
  //     {
  //       'productId': productId,
  //       'quantity': quantity,
  //       'chose': choose,
  //       'extra': extras,
  //       'note': note,
  //       'price': price,
  //     },
  //   ],
  // };

  // void reOrder(Map<String, dynamic> productDetails) {
  //   // int? index;
  //   // int? quantity;
  //   // bool? isEqual;
  //   if (reOrderedUserOrder.isEmpty) {
  //     reOrderedUserOrder.add(productDetails);
  //     return;
  //   }
  //   for (var element in reOrderedUserOrder) {
  //     if (mapEquals(element, productDetails)) {
  //       // isEqual = true;
  //       var index = reOrderedUserOrder.indexOf(element);
  //       var quantity = reOrderedUserOrder[index]['quantity'];
  //       print("aslifhasflih");
  //       reOrderedUserOrder[index]['quantity'] = quantity! + 1;
  //       print("reOrderdList:: $reOrderedUserOrder");
  //       return;
  //     } else {
  //       reOrderedUserOrder.add(productDetails);
  //       print("reOrderdList:: $reOrderedUserOrder");
  //     }
  //   }
  //   // if (isEqual != null && isEqual) {
  //   //   reOrderedUserOrder[index!]['quantity'] = quantity! + 1;
  //   //   print("reOrderdList:: $reOrderedUserOrder");
  //   // }
  // }

  void addProduct({
    required int productId,
    required int quantity,
    required int choose,
    required List<int> extras,
    required String note,
    required double price,
    required int restaurantId,
  }) {
    final productDetails = {
      'productId': productId,
      'quantity': quantity,
      'chose': choose,
      'extra': extras,
      'note': note,
      'price': price,
    };

    userOrder.add(productDetails);
    log("userOrder:: $userOrder -- length ${userOrder.length}");
    update();
  }

  void removeProduct({
    required int productId,
    required int quantity,
    required int choose,
    required List<int> extras,
    required String note,
    required double price,
  }) {
    final productDetails = {
      'productId': productId,
      'quantity': quantity,
      'chose': choose,
      'extra': extras,
      'note': note,
      'price': price,
    };

    userOrder.remove(productDetails);
    log("userOrder:: $userOrder -- length ${userOrder.length}");
    update();
  }

  Future fetchMakeOrderData({
    required BuildContext context,
    required int total,
    required int restaurantId,
  }) async {
    OverLayLoader.showLoading(context);
    makeOrderModel = await MakeOrderApi.data(
      userOrder: userOrder,
      total: total,
      restaurantId: restaurantId,
    );
    if (makeOrderModel == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (makeOrderModel!.code == 200) {
      Get.to(() => const BasketScreen());
    } else {
      Fluttertoast.showToast(msg: makeOrderModel!.msg!);
    }
    Loader.hide();
  }
}
