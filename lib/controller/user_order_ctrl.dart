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
  Map<String, dynamic> userOrderMap = {};
  final total = 0.0.obs;
  MakeOrderModel? makeOrderModel;

  //     {
  //       "product_id": 1,
  //       "quantity": 5,
  //       "size_id": 1,
  //       "extras": [
  //         {"extra_id": 1}
  //       ],
  //       "note": "Product Note",
  //       "price": 10
  //     },

  void calculateTotal(double price) {
    total.value = total.value + price;
  }

  bool checkIfItemAlreadyExist(Map<String, dynamic> productDetails) {
    bool isPreExist = false;
    for (var element in userOrder) {
      if (productDetails.toString() == element.toString()) {
        element['quantity']++;
        isPreExist = true;
        break;
      }
    }
    return isPreExist;
  }

  void addProduct({
    required int productId,
    required int quantity,
    required int size,
    required List<int> extras,
    required String note,
    required double price,
    required int extraId,
    required int restaurantId,
  }) {
    final productDetails = {
      'product_id': productId,
      'quantity': quantity,
      'extras': [
        {
          'extra_id': extraId,
        },
      ],
      'size_id': size,
      'note': "note",
      'price': price
    };
    if (userOrder.isEmpty) {
      userOrder.add(productDetails);
    } else {
      if (!checkIfItemAlreadyExist(productDetails)) {
        userOrder.add(productDetails);
      }
    }
    log("userOrder:: $userOrder -- length ${userOrder.length}");
    update();
  }

  void removeProduct({
    required int productId,
    required int quantity,
    required int size,
    required List<int> extras,
    required String note,
    required int extraId,
    required double price,
  }) {
    final productDetails = {
      'product_id': productId,
      'quantity': quantity,
      'extras': [
        {
          'extra_id': extraId,
        },
      ],
      'size_id': size,
      'note': note,
      'price': price
    };

    userOrder.remove(productDetails);
    log("userOrder:: $userOrder -- length ${userOrder.length}");
    update();
  }

  Future fetchMakeOrderData({
    required BuildContext context,
    required int restaurantId,
  }) async {
    OverLayLoader.showLoading(context);
    makeOrderModel = await MakeOrderApi.data(
      userOrder: userOrder,
      total: total.value,
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
