import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class TranslationService {
  static final Map<String, String> english = {};
  static final Map<String, String> arabic = {};
  static final baseCollection = FirebaseFirestore.instance.collection("translation");

  static Future addToFirebase(String key) async {
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
    addToFirebase(key); //TODO: delete this function on the final release and after making sure all strings are translated
    if (MySharedPreferences.language == 'en') {
      return english.containsKey(key) && english[key]!.isNotEmpty ? english[key]! : key;
    } else {
      return arabic.containsKey(key) && arabic[key]!.isNotEmpty ? arabic[key]! : key;
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
  }

  static Future init() async {
    await getEnglishFile();
    await getArabicFile();
  }
}
