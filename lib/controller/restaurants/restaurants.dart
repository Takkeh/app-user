import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/restaurants_model.dart';
import 'package:takkeh/network/restaurants/restaurants.dart';

class RestaurantsCtrl extends GetxController {
  RestaurantsModel? restaurantsModel;
  late ScrollController scrollCtrl;
  final restaurants = <Restaurants>[].obs;
  final isLoading = false.obs;
  final loadMore = false.obs;
  bool allLoaded = false;
  int limit = 1;

  void toggleLoading(String loadingCase, bool status) {
    switch (loadingCase) {
      case "load_more":
        {
          loadMore.value = status;
        }
        break;
      default:
        {
          isLoading.value = status;
        }
        break;
    }
    update();
  }

  Future<RestaurantsModel?> fetchCategoriesData(int page, String loadingCase) async {
    toggleLoading(loadingCase, true);
    restaurantsModel = await RestaurantsApi.data(page);
    if (restaurantsModel == null) {
      toggleLoading(loadingCase, false);
      return null;
    }
    if (restaurantsModel!.products!.isNotEmpty) {
      restaurants.addAll(restaurantsModel!.products!);
      limit++;
    } else {
      allLoaded = true;
    }
    update();
    toggleLoading(loadingCase, false);
    return restaurantsModel;
  }

  @override
  void onInit() {
    fetchCategoriesData(1, "default");
    scrollCtrl = ScrollController()
      ..addListener(() {
        if (scrollCtrl.offset == scrollCtrl.position.maxScrollExtent) {
          if (!allLoaded && !loadMore.value) {
            fetchCategoriesData(limit, "load_more");
          }
        }
      });
    super.onInit();
  }
}
