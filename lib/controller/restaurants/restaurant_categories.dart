import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/restaurants.dart';
import 'package:takkeh/model/restaurants/restaurant_categories_model.dart';
import 'package:takkeh/network/restaurants/restaurant_categories.dart';

class RestaurantCategoriesController extends GetxController {
  static RestaurantCategoriesController get find => Get.find();

  final currentIndex = 0.obs;
  final categoryTitle = "".obs;
  int filterId = 1;

  void updateCategories(id) {
    RestaurantsCtrl.find.fetchCategoriesData(1, id);
  }

  void onPageChanged(index, name, id) {
    currentIndex.value = index;
    categoryTitle.value = name;
    filterId = id;
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
