import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/view_product.dart';

class ViewProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewProductCtrl());
  }
}
