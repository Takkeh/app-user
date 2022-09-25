import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/filter.dart';
import 'package:takkeh/controller/restaurants/restaurant_categories.dart';
import 'package:takkeh/controller/restaurants/restaurants.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';

class RestaurantsHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RestaurantCategoriesController());
    Get.lazyPut(() => RestaurantsFilterController());
    Get.lazyPut(() => RestaurantsCtrl());
    Get.put(UserOrderCtrl());
  }
}
