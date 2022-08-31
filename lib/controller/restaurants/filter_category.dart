import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/filter_category_model.dart';
import 'package:takkeh/network/restaurants/filter_category.dart';

class FilterCategoryCtrl extends GetxController {
  static FilterCategoryCtrl get find => Get.find();

  FilterCategoryModel? filterCategoryModel;
  late ScrollController scrollCtrl;
  final filterCategory = <FilterCategory>[].obs;
  final isLoading = false.obs;
  final loadMore = false.obs;
  final allLoaded = false.obs;
  int limit = 1;

  List<GlobalKey> itemKeys = [];

  Future scrollToItem(index) async {
    await Scrollable.ensureVisible(
      itemKeys[index].currentContext!,
      alignment: 0.02,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void detect(int index) {
    RenderBox box = itemKeys[index].currentContext!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    // print("value:: $position - ${itemKeys.length}");
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

  Future<FilterCategoryModel?> fetchCategoriesData(int page, String loadingCase) async {
    toggleLoading(loadingCase, true);
    filterCategoryModel = await FilterCategoryApi.data(page);
    if (filterCategoryModel == null) {
      toggleLoading(loadingCase, false);
      return null;
    }
    if (filterCategoryModel!.products!.isNotEmpty) {
      filterCategory.addAll(filterCategoryModel!.products!);
      limit++;
    } else {
      allLoaded.value = true;
    }
    update();
    toggleLoading(loadingCase, false);
    return filterCategoryModel;
  }

  @override
  void onInit() {
    fetchCategoriesData(1, "default");

    // itemKeys = List.generate(filterCategory.length, (index) => GlobalKey());
    scrollCtrl = ScrollController()
      ..addListener(() {
        detect(1);
        if (scrollCtrl.offset == scrollCtrl.position.maxScrollExtent) {
          if (!allLoaded.value && !loadMore.value) {
            fetchCategoriesData(limit, "load_more");
          }
        }
      });
    super.onInit();
  }
}
