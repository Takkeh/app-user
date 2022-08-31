import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/products_filter_model.dart';
import 'package:takkeh/network/restaurants/products_filter.dart';

class ProductsFilterCtrl extends GetxController {
  static ProductsFilterCtrl get find => Get.find();

  ProductsFilterModel? productsFilterModel;
  late ScrollController scrollCtrl;
  final filters = <ProductFilter>[].obs;
  final isLoading = false.obs;
  final loadMore = false.obs;
  final allLoaded = false.obs;
  int limit = 1;

  final currentIndex = 0.obs;

  void toggle(int index) {
    currentIndex.value = index;
    update();
  }

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

  Future<ProductsFilterModel?> fetchCategoriesData(int page, String loadingCase) async {
    toggleLoading(loadingCase, true);
    productsFilterModel = await ProductsFilterApi.data(page);
    if (productsFilterModel == null) {
      toggleLoading(loadingCase, false);
      return null;
    }
    if (productsFilterModel!.products!.isNotEmpty) {
      filters.addAll(productsFilterModel!.products!);
      limit++;
    } else {
      allLoaded.value = true;
    }
    update();
    toggleLoading(loadingCase, false);
    return productsFilterModel;
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
