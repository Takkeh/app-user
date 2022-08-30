import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/most_popular.dart';
import 'package:takkeh/controller/restaurants/products_filter.dart';

class ProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductsFilterCtrl());
    Get.lazyPut(() => MostPopularFilterCtrl());
  }
}
