import 'dart:developer';

import 'package:get/get.dart';

class UserOrderCtrl extends GetxController {
  static UserOrderCtrl get find => Get.find();

  int restaurantId = 0;

  final orderList = <Map<String, dynamic>>[].obs;
  final totalPrice = 0.0.obs;
  final totalQuantity = 0.obs;

  void calculateTotalPrice(double price, {required String status}) {
    if (status == 'add') {
      totalPrice.value = totalPrice.value + price;
    } else {
      totalPrice.value = totalPrice.value - price;
    }
    log("totalPrice:: ${totalPrice.value}");
    update();
  }

  void calculateTotalQuantity(int quantity, {required String status}) {
    if (status == 'add') {
      totalQuantity.value = totalQuantity.value + quantity;
    } else {
      totalQuantity.value = totalQuantity.value - quantity;
    }
    log("totalQuantity:: ${totalQuantity.value}");
    update();
  }
}
