import 'package:get/get.dart';

class NavBarCtrl extends GetxController {
  static NavBarCtrl get find => Get.find();

  final isHidden = false.obs;

  void toggle(bool value) {
    isHidden.value = value;
    update();
  }
}
