import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/most_popular_products.dart';
import 'package:takkeh/controller/restaurants/products_filter.dart';
import 'package:takkeh/controller/restaurants/view_restaurant.dart';

class ProductBinding implements Bindings {
  final int id;
  ProductBinding({required this.id});

  @override
  void dependencies() {
    Get.lazyPut(() => ProductsFilterCtrl());
    Get.lazyPut(() => MostPopularProductsCtrl(restaurantId: id));
    Get.lazyPut(() => ViewRestaurantCtrl(restaurantId: id));
  }
}
