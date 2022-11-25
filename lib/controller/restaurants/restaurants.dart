import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/restaurants_model.dart';
import 'package:takkeh/network/restaurants/restaurants.dart';

class RestaurantsCtrl extends GetxController {
  static RestaurantsCtrl get find => Get.find();

  RestaurantsModel? model;
  late Future<RestaurantsModel?> initialize;

  Future<RestaurantsModel?> fetchCategoriesData(int filterId, int categoryId) async {
    model = await RestaurantsApi.data(0, 0);
    return model;
  }

  @override
  void onInit() {
    initialize = fetchCategoriesData(0, 0);
    super.onInit();
  }
}
