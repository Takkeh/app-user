import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/shop/restaurant_categories_model.dart';
import 'package:takkeh/network/restaurants/shop/restaurant_categories.dart';

class RestaurantCategoriesController extends GetxController {
  static RestaurantCategoriesController get find => Get.find();

  RestaurantCategoriesModel? restaurantCategoriesModel;
  late Future<RestaurantCategoriesModel?> initialize;

  Future<RestaurantCategoriesModel?> fetchRestaurantCategoriesData() async {
    restaurantCategoriesModel = await RestaurantCategoriesApi.data();
    return restaurantCategoriesModel;
  }

  @override
  void onInit() {
    super.onInit();
    initialize = fetchRestaurantCategoriesData();
  }
}
