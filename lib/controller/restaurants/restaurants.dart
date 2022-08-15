import 'package:takkeh/model/restaurants/restaurants_model.dart';
import 'package:takkeh/network/restaurants/restaurants.dart';

class RestaurantsController {
  static RestaurantsModel? restaurantsModel;
  static late Future<RestaurantsModel?> restaurantsData;

  static Future<RestaurantsModel?> fetchCategoriesData() async {
    restaurantsModel = await RestaurantsApi.data();
    return restaurantsModel;
  }
}
