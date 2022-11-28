import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/restaurant_reviews.dart';

class RestaurantInfoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RestaurantReviewsCtrl());
  }

}