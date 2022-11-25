import 'package:get/get.dart';
import 'package:takkeh/controller/view_product_ctrl.dart';

class ViewProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewProductCtrl());
  }
}
