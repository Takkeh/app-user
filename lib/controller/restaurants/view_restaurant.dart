import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/view_restaurant.dart';
import 'package:takkeh/network/restaurants/filter_category.dart';

class ViewRestaurantCtrl extends GetxController {
  final int id;
  ViewRestaurantCtrl({required this.id});

  static ViewRestaurantCtrl get find => Get.find();

  ViewRestaurantModel? viewRestaurantModel;
  late ScrollController scrollCtrl;
  final viewRestaurants = <ViewRestaurants>[].obs;
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

  Future<ViewRestaurantModel?> fetchViewRestaurantData(int page, String loadingCase, int id) async {
    toggleLoading(loadingCase, true);
    viewRestaurantModel = await ViewRestaurantApi.data(page, id);
    if (viewRestaurantModel == null) {
      toggleLoading(loadingCase, false);
      return null;
    }
    if (viewRestaurantModel!.data!.products!.isNotEmpty) {
      viewRestaurants.addAll(viewRestaurantModel!.data!.products!);
      print("length::::: ${viewRestaurantModel!.data!.products!}");
      limit++;
    } else {
      allLoaded.value = true;
    }
    update();
    toggleLoading(loadingCase, false);
    return viewRestaurantModel;
  }

  @override
  void onInit() {
    fetchViewRestaurantData(1, "default", id);

    // itemKeys = List.generate(filterCategory.length, (index) => GlobalKey());
    scrollCtrl = ScrollController()
      ..addListener(() {
        detect(1);
        print("position:: ${scrollCtrl.position.atEdge}");
        if (scrollCtrl.offset == scrollCtrl.position.maxScrollExtent) {
          if (!allLoaded.value && !loadMore.value) {
            fetchViewRestaurantData(limit, "load_more", id);
          }
        }
      });
    super.onInit();
  }
}
