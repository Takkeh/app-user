import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/ui/registration/registration.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/images.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(MyImages.logo),
              const Text(
                AppConstants.introText,
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => const RegistrationScreen());
                  MySharedPreferences.isPassedIntro = true;
                },
                child: const Text(
                  "Get started",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
