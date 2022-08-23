import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class TranslationService {
  static Map<String, dynamic> baseStrings = {};
  static Map<String, String> english = {};
  static final baseCollection = FirebaseFirestore.instance.collection("translation");

  static String? getString(String value) {
    if (MySharedPreferences.language == 'en') {
      return english[value] != '' ? baseStrings[value][0]! : "Firebase Translation";
    } else {
      return baseStrings[value][1]! != '' ? baseStrings[value][1]! : "تترجم لاحقا";
    }
  }

  static void add(dynamic value) {
    baseStrings.addAll(Map<String, List<dynamic>>.from(value));
  }

  static Future init() async {
    final keys = await baseCollection.doc('english').get();
    var file = json.decode(keys.data()!['keys']);
    print("file:: ${file.runtimeType}");
    english.addAll(file);
    print("file:: $file");
  }
}
