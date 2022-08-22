import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get find => Get.find();

  final isPasswordObscure = true.obs;
  final isConfirmPasswordObscure = true.obs;

  void changePasswordObscure() {
    isPasswordObscure.value = !isPasswordObscure.value;
    update();
  }

  void changeConfirmPasswordObscure() {
    isConfirmPasswordObscure.value = !isConfirmPasswordObscure.value;
    update();
  }
}
