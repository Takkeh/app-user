import 'package:get/get.dart';

class ChangePassCtrl extends GetxController {
  static ChangePassCtrl get find => Get.find();

  final isCurrentPasswordObscure = true.obs;
  final isNewPasswordObscure = true.obs;
  final isConfirmNewPasswordObscure = true.obs;

  void changeCurrentPasswordObscure() {
    isCurrentPasswordObscure.value = !isCurrentPasswordObscure.value;
    update();
  }

  void changeNewPasswordObscure() {
    isNewPasswordObscure.value = !isNewPasswordObscure.value;
    update();
  }

  void changeConfirmNewPasswordObscure() {
    isConfirmNewPasswordObscure.value = !isConfirmNewPasswordObscure.value;
    update();
  }
}
