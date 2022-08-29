import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/restaurant_categories_model.dart';
import 'package:takkeh/network/restaurants/restaurant_categories.dart';

class RestaurantCategoriesController extends GetxController {
  static RestaurantCategoriesController get find => Get.find();

  final currentIndex = 0.obs;
  final categoryTitle = "".obs;

  void onPageChanged(index, name) {
    currentIndex.value = index;
    categoryTitle.value = name;
    update();
  }

  void getTitle(String value) {
    categoryTitle.value = value;
    update();
  }

  //...
  RestaurantCategoriesModel? restaurantCategoriesModel;
  late Future<RestaurantCategoriesModel?> initialize;

  Future<RestaurantCategoriesModel?> fetchRestaurantCategoriesData() async {
    restaurantCategoriesModel = await RestaurantCategoriesApi.data();
    getTitle(restaurantCategoriesModel!.categorys![0].name!);
    return restaurantCategoriesModel;
  }

  @override
  void onInit() {
    super.onInit();
    initialize = fetchRestaurantCategoriesData();
  }
}
