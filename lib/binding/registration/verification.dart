import 'package:get/get.dart';
import 'package:takkeh/controller/registration/verification.dart';

class VerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerificationController());
  }
}
