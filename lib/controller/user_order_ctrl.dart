import 'dart:developer';

import 'package:get/get.dart';

class UserOrderCtrl extends GetxController {
  static UserOrderCtrl get find => Get.find();
  final userOrder = <Map<String, dynamic>>[].obs;
  final total = 0.0.obs;

  int getProductQuantity(int id) {
    int quantity = 0;
    for (var element in userOrder) {
      if (element['product_id'] == id) {
        quantity = quantity + element['quantity'] as int;
      }
    }
    return quantity;
  }

  void calculateTotal(double price) {
    total.value = total.value + price;
  }

  bool checkIfItemAlreadyExist(Map<String, dynamic> productDetails) {
    bool isPreExist = false;
    for (var element in userOrder) {
      var check = productDetails['product_id'].toString() == element['product_id'].toString() && productDetails['extras'].toString() == element['extras'].toString() && productDetails['size_id'].toString() == element['size_id'].toString() && productDetails['note'].toString() == element['note'].toString();
      if (check) {
        element['quantity'] = element['quantity'] + productDetails['quantity'];
        element['price'] = element['price'] + productDetails['price'];
        isPreExist = true;
        break;
      }
    }
    log("userOrder:: $userOrder -- length ${userOrder.length}");
    return isPreExist;
  }

  void addProduct({
    required int productId,
    required int quantity,
    required int size,
    required List<Map<String, int>> extras,
    required String note,
    required double price,
    required int extraId,
    required int restaurantId,
  }) {
    final productDetails = {
      'product_id': productId,
      'quantity': quantity,
      'extras': extras,
      'size_id': size,
      'note': "note",
      'price': price,
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
}
