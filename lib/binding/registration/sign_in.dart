import 'package:get/get.dart';
import 'package:takkeh/controller/registration/sign_in.dart';
import 'package:takkeh/controller/registration/social_sign_in_ctrl.dart';

class RegistrationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SocialSignInController());
  }
}
