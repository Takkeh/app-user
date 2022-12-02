import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/registration/sign_in.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration/registration.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: Get.height * 0.65,
              width: double.infinity,
              child: Image.asset(
                MyImages.intro,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Get.height * 0.55,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60),
              decoration: const BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(80),
                  topLeft: Radius.circular(80),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    TranslationService.getString("intro_title_key"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      color: MyColors.text,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    TranslationService.getString("intro_description_key"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: MyColors.text,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-1, 1),
            child: InkWell(
              onTap: () {
                Get.to(() => const RegistrationScreen(), binding: RegistrationBinding());
                MySharedPreferences.isPassedIntro = true;
              },
              child: Stack(
                alignment: const AlignmentDirectional(0, 0.2),
                children: [
                  Image.asset(
                    MySharedPreferences.language == "en" ? MyImages.leftSemiCircle : MyImages.rightSemiCircle,
                    height: 110,
                  ),
                  const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
