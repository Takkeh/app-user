import 'package:flutter/material.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/screens/registration/widgets/phone_suffix_icon.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class PhoneFieldHelper {
  static Widget togglePrefixIcon() {
    if (MySharedPreferences.language == 'ar') {
      return CustomPrefixIcon(
        icon: MyIcons.circlePhone,
        textDirection: MySharedPreferences.language == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      );
    } else {
      return PhoneSuffixIcon(
        textDirection: MySharedPreferences.language == 'ar' ? TextDirection.rtl : TextDirection.ltr,
      );
    }
  }

  static Widget toggleSuffixIcon() {
    if (MySharedPreferences.language == 'en') {
      return CustomPrefixIcon(
        icon: MyIcons.circlePhone,
        textDirection: MySharedPreferences.language == 'en' ? TextDirection.rtl : TextDirection.ltr,
      );
    } else {
      return PhoneSuffixIcon(
        textDirection: MySharedPreferences.language == 'en' ? TextDirection.rtl : TextDirection.ltr,
      );
    }
  }
}
