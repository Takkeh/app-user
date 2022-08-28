import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CodeTimerController extends GetxController {
  static CodeTimerController get find => Get.find();

  Timer? timer;
  final counter = 60.obs;

  Future startTimer(BuildContext context, String phone) async {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) async {
        if (counter.value == 0) {
          update();
        } else {
          counter.value--;
          update();
        }
      },
    );
  }
}
