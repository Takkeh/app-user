import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/registration/code_timer_controller.dart';
import 'package:takkeh/controller/registration/reset_pass/step1.dart';
import 'package:takkeh/utils/base/colors.dart';

class OtpCounterWidget extends StatelessWidget {
  final String phone;

  const OtpCounterWidget({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, bottom: 50),
      child: GetBuilder<CodeTimerController>(
        builder: (controller) {
          if (controller.counter.value == 0) {
            return ElevatedButton(
              onPressed: () {
                controller.counter.value = 60;
                ResetPassStep1Controller.fetchOtpData(context: context, phone: phone);
              },
              child: const Text("resend_otp_key"),
            );
          } else {
            return RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'Resend '.tr,
                    style: const TextStyle(
                      color: MyColors.text,
                    ),
                  ),
                  TextSpan(
                    text: '${"After".tr} ${controller.counter.value} ${"seconds".tr}',
                    style: const TextStyle(
                      color: MyColors.redD4F,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
