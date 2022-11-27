import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/restaurant_reviews_model.dart';
import 'package:takkeh/network/restaurants/restaurant_reviews.dart';

class RestaurantReviewsCtrl extends GetxController {
  static RestaurantReviewsCtrl get find => Get.find();

  RestaurantReviewsModel? model;
  late Future<RestaurantReviewsModel?> initialize;

  Future<RestaurantReviewsModel?> fetchRestaurantReviews({required int restaurantId}) async {
    model = await RestaurantReviewsApi.data(id: restaurantId);
    return model;
  }

}