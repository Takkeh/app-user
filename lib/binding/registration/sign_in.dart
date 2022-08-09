import 'package:get/get.dart';
import 'package:takkeh/controller/registration/sign_in.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}
