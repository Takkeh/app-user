import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/registration/reset_pass/step1.dart';

class CodeTimerController extends GetxController {
  static CodeTimerController get find => Get.find();

  Timer? timer;
  final counter = 60.obs;

  Future startTimer(BuildContext context, String phone) async {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) async {
        if (counter.value == 0) {
          await ResetPassStep1Controller.fetchOtpData(context: context, phone: phone);
          counter.value = 60;
          update();
        } else {
          counter.value--;
          update();
        }
      },
    );
  }
}
