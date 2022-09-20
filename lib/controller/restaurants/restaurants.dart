import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/restaurant_categories.dart';
import 'package:takkeh/model/restaurants/restaurants_model.dart';
import 'package:takkeh/network/restaurants/restaurants.dart';

class RestaurantsCtrl extends GetxController {
  static RestaurantsCtrl get find => Get.find();

  RestaurantsModel? restaurantsModel;
  late ScrollController scrollCtrl;
  final restaurants = <Restaurants>[].obs;
  final isLoading = false.obs;
  final loadMore = false.obs;
  final allLoaded = false.obs;
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

  Future<RestaurantsModel?> fetchCategoriesData(int page, String loadingCase, int filter) async {
    toggleLoading(loadingCase, true);
    restaurantsModel = await RestaurantsApi.data(page, filter);
    if (restaurantsModel == null) {
      toggleLoading(loadingCase, false);
      return null;
    }
    if (restaurantsModel!.data!.isNotEmpty) {
      restaurants.addAll(restaurantsModel!.data!);
      print("length:: ${restaurantsModel!.data!.length}");
      limit++;
    } else {
      allLoaded.value = true;
    }
    update();
    toggleLoading(loadingCase, false);
    return restaurantsModel;
  }

  void loadMoreCategories(int filterId) {
    if (scrollCtrl.offset == scrollCtrl.position.maxScrollExtent) {
      if (!allLoaded.value && !loadMore.value) {
        fetchCategoriesData(limit, "load_more", filterId);
      }
    }
  }

  @override
  void onInit() {
    fetchCategoriesData(1, "default", 1);
    scrollCtrl = ScrollController()
      ..addListener(() {
        loadMoreCategories(RestaurantCategoriesController.find.filterId);
      });
    super.onInit();
  }
}
