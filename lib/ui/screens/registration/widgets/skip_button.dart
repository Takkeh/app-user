import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/nav_bar.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/base/nav_bar.dart';
import 'package:takkeh/utils/base/images.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(1, 1),
      child: GestureDetector(
        onTap: () {
          Get.offAll(() => const BaseNavBar(), binding: NavBarBinding());
        },
        child: Stack(
          alignment: const AlignmentDirectional(0.5, 0.3),
          children: [
            Transform(
              alignment: Alignment.center,
              transform: MySharedPreferences.language == 'en' ? Matrix4.rotationY(pi) : Matrix4.rotationY(0),
              child: Image.asset(
                MyImages.leftSemiCircle,
                height: 110,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(height: 5),
                Text(
                  TranslationService.getString("skip_key"),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
