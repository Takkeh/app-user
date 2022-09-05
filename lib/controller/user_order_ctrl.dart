import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class UserOrderCtrl extends GetxController {
  static UserOrderCtrl get find => Get.find();
  final userOrder = <Map<String, dynamic>>[].obs;
  final reOrderedUserOrder = <Map<String, dynamic>>[].obs;

  void reOrder(Map<String, dynamic> productDetails) {
    // int? index;
    // int? quantity;
    // bool? isEqual;
    if (reOrderedUserOrder.isEmpty) {
      reOrderedUserOrder.add(productDetails);
      return;
    }
    for (var element in reOrderedUserOrder) {
      if (mapEquals(element, productDetails)) {
        // isEqual = true;
        var index = reOrderedUserOrder.indexOf(element);
        var quantity = reOrderedUserOrder[index]['quantity'];
        print("aslifhasflih");
        reOrderedUserOrder[index]['quantity'] = quantity! + 1;
        print("reOrderdList:: $reOrderedUserOrder");
        return;
      } else {
        reOrderedUserOrder.add(productDetails);
        print("reOrderdList:: $reOrderedUserOrder");
      }
    }
    // if (isEqual != null && isEqual) {
    //   reOrderedUserOrder[index!]['quantity'] = quantity! + 1;
    //   print("reOrderdList:: $reOrderedUserOrder");
    // }
  }

  void addProduct({
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
}
