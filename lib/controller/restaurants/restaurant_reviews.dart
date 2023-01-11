import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:takkeh/model/restaurants/restaurant_info_model.dart';
import 'package:takkeh/network/restaurants/restaurant_reviews.dart';

class RestaurantReviewsCtrl extends GetxController {
  static RestaurantReviewsCtrl get find => Get.find();

  late PagingController<int, Review> pagingController;
  int? restaurantId;

  Future<void> fetchPage(int pageKey) async {
    try {
      final model = await RestaurantReviewsApi.data(pageKey: pageKey, id: restaurantId!);
      final newItems = model!.data!.reviews;
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
        fetchPage(pageKey);
        print("STSTPagingStatus:: ${pagingController.value.status}");
      });
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
