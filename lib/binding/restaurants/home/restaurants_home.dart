import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/shop/restaurant_categories.dart';

class RestaurantsHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RestaurantCategoriesController());
  }
}
