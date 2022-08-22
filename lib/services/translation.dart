import 'package:cloud_firestore/cloud_firestore.dart';

class TranslationService {
  static final translationCollection = FirebaseFirestore.instance.collection("translation");
  static final registrationTranslation = translationCollection.doc("registration").collection("screens").doc("sign up");
}
