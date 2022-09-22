import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/view_product_model.dart';
import 'package:takkeh/network/restaurants/view_product.dart';

class ViewRestaurantProductCtrl extends GetxController {
  final int id;
  ViewRestaurantProductCtrl({required this.id});

  static ViewRestaurantProductCtrl get find => Get.find();

  final counter = 1.obs;

  String getPrice(double price) {
    return (price * counter.value).toString();
  }

  void toggleCounter(String status) {
    if (status == 'add') {
      counter.value++;
    } else {
      if (counter.value == 1) return;
      counter.value--;
    }
    update();
  }

  ViewRestaurantProductModel? viewProductModel;
  late Future<ViewRestaurantProductModel?> initialize;

  Future<ViewRestaurantProductModel?> fetchRestaurantCategoriesData() async {
    viewProductModel = await ViewRestaurantProductApi.data(id);
    return viewProductModel;
  }

  @override
  void onInit() {
    super.onInit();
    initialize = fetchRestaurantCategoriesData();
  }
}
