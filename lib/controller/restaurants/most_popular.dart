import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/most_popular_model.dart';
import 'package:takkeh/network/restaurants/most_popular.dart';

class MostPopularFilterCtrl extends GetxController {
  MostPopularModel? mostPopularModel;
  late ScrollController scrollCtrl;
  final mostPopular = <MostPopular>[].obs;
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

  Future<MostPopularModel?> fetchCategoriesData(int page, String loadingCase) async {
    toggleLoading(loadingCase, true);
    mostPopularModel = await MostPopularApi.data(page);
    if (mostPopularModel == null) {
      toggleLoading(loadingCase, false);
      return null;
    }
    if (mostPopularModel!.products!.isNotEmpty) {
      mostPopular.addAll(mostPopularModel!.products!);
      limit++;
    } else {
      allLoaded.value = true;
    }
    update();
    toggleLoading(loadingCase, false);
    return mostPopularModel;
  }

  @override
  void onInit() {
    fetchCategoriesData(1, "default");
    scrollCtrl = ScrollController()
      ..addListener(() {
        if (scrollCtrl.offset == scrollCtrl.position.maxScrollExtent) {
          if (!allLoaded.value && !loadMore.value) {
            fetchCategoriesData(limit, "load_more");
          }
        }
      });
    super.onInit();
  }
}
