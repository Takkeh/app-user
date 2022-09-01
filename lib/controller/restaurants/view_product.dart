import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/view_product_model.dart';
import 'package:takkeh/network/restaurants/view_product.dart';

class ViewProductCtrl extends GetxController {
  static ViewProductCtrl get find => Get.find();

  final counter = 1.obs;

  String getPrice(double price) {
    return (price * counter.value).toString();
  }

  void toggle(String status) {
    if (status == 'add') {
      counter.value++;
    } else {
      if (counter.value == 1) return;
      counter.value--;
    }
    update();
  }

  ViewProductModel? viewProductModel;
  late Future<ViewProductModel?> initialize;

  Future<ViewProductModel?> fetchRestaurantCategoriesData() async {
    viewProductModel = await ViewProductApi.data();
    return viewProductModel;
  }

  @override
  void onInit() {
    super.onInit();
    initialize = fetchRestaurantCategoriesData();
  }
}
