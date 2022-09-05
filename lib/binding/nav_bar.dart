import 'package:get/get.dart';
import 'package:takkeh/controller/home/offers.dart';
import 'package:takkeh/controller/home/slider.dart';
import 'package:takkeh/controller/home/special_offers.dart';
import 'package:takkeh/controller/nav_bar_ctrl.dart';
import 'package:takkeh/controller/registration/sign_in.dart';
import 'package:takkeh/controller/user_location.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';

class NavBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SliderController());
    Get.lazyPut(() => OffersController());
    Get.lazyPut(() => SpecialOffersController());
    Get.put(NavBarCtrl(), permanent: true);
    Get.put(UserLocationCtrl(), permanent: true);
    Get.put(UserOrderCtrl(), permanent: true);
  }
}
