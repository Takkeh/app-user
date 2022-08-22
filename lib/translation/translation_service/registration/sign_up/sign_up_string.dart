import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class AppStringsService {
  static Map<String, dynamic> myStrings = {};

  static final baseCollection = FirebaseFirestore.instance.collection("translation");

  //registration
  static final registration = baseCollection.doc("registration").collection("screens");
  static final signUpDoc = registration.doc("sign up");
  static final signInDoc = registration.doc("sign in");

  static Future fetchRegistration() async {
    final signUpData = await signUpDoc.get();
    myStrings.addAll(Map<String, List<dynamic>>.from(signUpData.data()!['text']));
    myStrings.addAll(Map<String, List<dynamic>>.from(signUpData.data()!['verification']));
    myStrings.addAll(Map<String, List<dynamic>>.from(signUpData.data()!['labels']));

    final signInData = await signInDoc.get();
    myStrings.addAll(Map<String, List<dynamic>>.from(signInData.data()!['test']));
  }

  static String? getString(String value) {
    if (MySharedPreferences.language == 'en') {
      return myStrings[value][0]!;
    } else {
      return myStrings[value][1]!;
    }
  }

  static Future init() async {
    fetchRegistration();
  }
}
