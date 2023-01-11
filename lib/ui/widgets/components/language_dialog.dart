import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class LanguageDialog {
  void show() {
    Get.defaultDialog(
      title: TranslationService.getString('language_key'),
      radius: 28,
      contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20.0),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomElevatedButton(
            padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
            title: TranslationService.getString('english_key'),
            onPressed: () {
              Get.back();
              if (MySharedPreferences.language == "en") return;
              MySharedPreferences.language = "en";
              Get.updateLocale(Locale(MySharedPreferences.language));
            },
          ),
          CustomElevatedButton(
            title: TranslationService.getString('arabic_key'),
            onPressed: () {
              Get.back();
              if (MySharedPreferences.language == "ar") return;
              MySharedPreferences.language = "ar";
              Get.updateLocale(Locale(MySharedPreferences.language));
            },
          ),
        ],
      ),
    );
  }
}
