import 'package:get/get.dart';

class ProductCounterCtrl extends GetxController {
  final counter = 1.obs;

  String getPrice(double price) {
    return (price * counter.value).toString();
  }

  void toggle(String status) {
    if (status == 'add') {
      counter.value++;
    } else {
      if (counter.value == 1) return;
      counter.value--;
    }
    update();
  }
}
