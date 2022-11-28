import 'package:get/get.dart';
import 'package:takkeh/controller/my_orders/my_orders_ctrl.dart';

class MyOrdersBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MyOrdersCtrl());
  }

}