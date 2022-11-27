import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:takkeh/controller/restaurants/filter.dart';
import 'package:takkeh/controller/restaurants/restaurant_categories.dart';
import 'package:takkeh/model/restaurants/restaurants_model.dart';
import 'package:takkeh/network/restaurants/restaurants.dart';

class RestaurantsCtrl extends GetxController {
  static RestaurantsCtrl get find => Get.find();

  late PagingController<int, RestaurantList> pagingController;

  Future<void> fetchPage(int tagId, int categoryId, int pageKey) async {
    try {
      final model = await RestaurantsApi.data(tagId: tagId, categoryId: categoryId, pageKey: pageKey);
      final newItems = model!.data;
      if (newItems!.isEmpty) {
        pagingController.appendLastPage(newItems);
      } else {
        pagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  void onInit() {
    pagingController = PagingController(firstPageKey: 1)
      ..addPageRequestListener((pageKey) {
        fetchPage(RestaurantsFilterController.find.selectedTagId.value, RestaurantCategoriesController.find.filterId, pageKey);
      });
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
