import 'dart:async';

import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/restaurants_products_search_model.dart';
import 'package:takkeh/network/restaurants/restuarant_products_search_api.dart';

class RestaurantProductsSearchCtrl extends GetxController {
  final int restaurantsId;

  RestaurantProductsSearchCtrl({required this.restaurantsId});

  static RestaurantProductsSearchCtrl get find => Get.find();

  RestaurantProductsSearchModel? model;
  late Future<RestaurantProductsSearchModel?> initialize;
  final searchQuery = "".obs;
  Timer? _debounce;

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        searchQuery.value = query;
        initialize = fetchCategoriesData(query);
      } else {
        searchQuery.value = "";
      }
    });
  }

  Future<RestaurantProductsSearchModel?> fetchCategoriesData(String query) async {
    model = await RestaurantProductsSearchApi().data(query: query, restaurantsId: restaurantsId);
    return model;
  }
}
