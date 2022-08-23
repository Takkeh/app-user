import 'package:get/get.dart';
import 'package:takkeh/controller/registration/code_timer_controller.dart';

class CodeTimerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CodeTimerController());
  }
}
