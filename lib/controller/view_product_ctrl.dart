import 'package:get/get.dart';

class ViewProductCtrl extends GetxController {
  static ViewProductCtrl get find => Get.find();

  final finalPrice = 0.0.obs;
  final quantity = 1.obs;

  final requiredGroupList = <String>[];
  final optionalGroupList = <String>[];

  void calculateQuantity(String status) {
    var price = finalPrice.value / quantity.value;
    if (status == 'add') {
      quantity.value++;
    } else {
      if (quantity.value == 1) return;
      quantity.value--;
    }
    finalPrice.value = price * quantity.value;
    update();
  }

  void calculatePrice({
    required double itemPrice,
    required String status,
  }) {
    if (status == 'add') {
      finalPrice.value = finalPrice.value + (itemPrice * quantity.value);
    }
    if (status == 'remove') {
      finalPrice.value = finalPrice.value - (itemPrice * quantity.value);
    }
    update();
  }
}
