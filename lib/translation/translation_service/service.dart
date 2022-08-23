import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:takkeh/translation/translation_service/screens/registration.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class TranslationService {
  static Map<String, dynamic> baseStrings = {};
  static final baseCollection = FirebaseFirestore.instance.collection("translation");

  static String? getString(String value) {
    if (MySharedPreferences.language == 'en') {
      return baseStrings[value][0]! != '' ? baseStrings[value][0]! : "Firebase Translation";
    } else {
      return baseStrings[value][1]! != '' ? baseStrings[value][1]! : "تترجم لاحقا";
    }
  }

  static void add(dynamic value) {
    baseStrings.addAll(Map<String, List<dynamic>>.from(value));
  }

  static Future init() async {
    await RegistrationTranslationService.fetchRegistration();
    log("value:: $baseStrings");
  }
}
