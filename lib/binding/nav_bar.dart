import 'package:get/get.dart';
import 'package:takkeh/controller/addresses/my_addresses_ctrl.dart';
import 'package:takkeh/controller/home/category.dart';
import 'package:takkeh/controller/home/offers.dart';
import 'package:takkeh/controller/home/slider.dart';
import 'package:takkeh/controller/home/special_offers.dart';
import 'package:takkeh/controller/nav_bar_ctrl.dart';
import 'package:takkeh/controller/restaurants/make_order.dart';
import 'package:takkeh/controller/user_location_ctrl.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';

class NavBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SliderController(), permanent: true);
    Get.put(CategoriesController(), permanent: true);
    Get.put(UserOrderCtrl(), permanent: true);
    Get.put(MyAddressesCtrl(), permanent: true);
    Get.put(UserLocationCtrl(), permanent: true);
    Get.put(MakeOrderCtrl(), permanent: true);
    Get.put(OffersController(), permanent: true);
    Get.put(SpecialOffersController(), permanent: true);
    Get.put(NavBarCtrl(), permanent: true);
  }
}
