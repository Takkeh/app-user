import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/product_counter.dart';

class ViewProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductCounterCtrl());
  }
}
