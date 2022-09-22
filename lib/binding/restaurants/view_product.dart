import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/view_product.dart';

class ViewProductBinding implements Bindings {
  final int id;
  ViewProductBinding({required this.id});

  @override
  void dependencies() {
    Get.lazyPut(() => ViewRestaurantProductCtrl(id: id));
  }
}
