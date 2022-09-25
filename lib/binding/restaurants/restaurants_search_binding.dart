import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/restaurants_search_ctrl.dart';

class RestaurantsSearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RestaurantsSearchCtrl());
  }
}
