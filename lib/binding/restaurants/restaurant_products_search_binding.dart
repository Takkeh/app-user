import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/restaurant_products_search_ctrl.dart';

class RestaurantProductsSearchBinding implements Bindings {
  final int restaurantsId;
  RestaurantProductsSearchBinding({required this.restaurantsId});

  @override
  void dependencies() {
    Get.lazyPut(() => RestaurantProductsSearchCtrl(restaurantsId: restaurantsId));
  }
}
