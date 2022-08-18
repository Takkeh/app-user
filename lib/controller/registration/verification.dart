import 'dart:async';

import 'package:get/get.dart';

class VerificationController extends GetxController {
  static VerificationController get find => Get.find();

  Timer? timer;
  final counter = 60.obs;

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (counter.value == 0) {
          timer.cancel();
          //call api again
        } else {
          counter.value--;
          update();
        }
      },
    );
  }

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }
}
