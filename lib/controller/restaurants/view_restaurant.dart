import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/view_restaurant.dart';
import 'package:takkeh/network/restaurants/filter_category.dart';

class ViewRestaurantCtrl extends GetxController {
  final int restaurantId;
  ViewRestaurantCtrl({required this.restaurantId});

  static ViewRestaurantCtrl get find => Get.find();

  ViewRestaurantModel? viewRestaurantModel;
  late Future<ViewRestaurantModel?> initialize;

  final selectedIndex = 0.obs;
  final restaurantProducts = <RestaurantProducts>[].obs;
  List<GlobalKey> itemKeys = [];

  Future<ViewRestaurantModel?> fetchCategoriesData(int restaurantId) async {
    viewRestaurantModel = await ViewRestaurantApi.data(restaurantId);
    restaurantProducts.addAll(viewRestaurantModel!.data!);
    update();
    return viewRestaurantModel;
  }

  Future scrollToItem(index) async {
    selectedIndex.value = index;
    update();
    await Scrollable.ensureVisible(
      itemKeys[index].currentContext!,
      alignment: 0.02,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onInit() {
    initialize = fetchCategoriesData(restaurantId);
    super.onInit();
  }
}
