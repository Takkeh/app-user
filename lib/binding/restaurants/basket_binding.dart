import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/add_promo_code_ctrl.dart';
import 'package:takkeh/controller/restaurants/promo_codes_ctrl.dart';

class PromoCodesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PromoCodesCtrl());
    Get.lazyPut(() => AddPromoCodeCtrl());
  }
}
