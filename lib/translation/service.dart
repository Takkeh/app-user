import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class TranslationService {
  static final Map<String, String> english = {};
  static final Map<String, String> arabic = {};
  static final baseCollection = FirebaseFirestore.instance.collection("translation");

  static addToFirebase(String key) async {
    if (english.containsKey(key)) return;
    english[key] = "";
    baseCollection.doc('english').update({
      'keys': english,
    });
    if (arabic.containsKey(key)) return;
    arabic[key] = "";
    baseCollection.doc('arabic').update({
      'keys': arabic,
    });
  }

  static String getString(String key) {
    addToFirebase(key);
    if (MySharedPreferences.language == 'en') {
      return english.containsKey(key) ? english[key]! : "Firebase Translation";
    } else {
      return arabic.containsKey(key) ? arabic[key]! : "يترجم لاحقا";
    }
  }

  static Future getEnglishFile() async {
    final keys = await baseCollection.doc('english').get();
    var file = Map<String, String>.from(keys.data()!['keys']);
    english.addAll(file);
  }

  static Future getArabicFile() async {
    final keys = await baseCollection.doc('arabic').get();
    var file = Map<String, String>.from(keys.data()!['keys']);
    arabic.addAll(file);
    print("arabic:: $arabic");
  }

  static Future init() async {
    await getEnglishFile();
    await getArabicFile();
  }
}
