import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class UserOrderCtrl extends GetxController {
  static UserOrderCtrl get find => Get.find();
  final userOrder = <Map<String, dynamic>>[].obs;

  // final userOrder = {
  //   'userId': 1,
  //   'products': [
  //     {
  //       'productId': 1,
  //       'quantity': 2,
  //       'chose': 1,
  //       'extra': [],
  //       'note': 'user note',
  //     },
  //   ],
  // };

  int? isAlreadyAdded(Map<String, dynamic> productDetails) {
    int? index;
    for (var element in userOrder) {
      if (mapEquals(element, productDetails)) {
        index = userOrder.indexOf(element);
      } else {
        index = null;
      }
    }
    return index!;
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
    if (isAlreadyAdded(productDetails) != null) {
      userOrder[isAlreadyAdded(productDetails)!]['quantity'] = quantity;
      return;
    }
    userOrder.add(productDetails);
    print("userOrder:: $userOrder -- ${userOrder.length}");
    update();
  }

  void removeProduct({
    required int productId,
    required int quantity,
    required int chose,
    required List<int> extras,
    required String note,
  }) {
    userOrder.remove(
      {
        'productId': productId,
        'quantity': quantity,
        'chose': chose,
        'extra': extras,
        'note': note,
      },
    );
    print("userOrder:: $userOrder -- ${userOrder.length}");
    update();
  }
}
