import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/products_filter.dart';

class ProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsFilterCtrl());
  }
}
