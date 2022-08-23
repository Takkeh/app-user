import 'package:takkeh/translation/translation_service/service.dart';

class RegistrationTranslationService {
  static final registration = TranslationService.baseCollection.doc("registration");

  static List<String> fields = [
    'sign in',
    'sign up',
  ];

  static Future fetchRegistration() async {
    final signUpData = await registration.get();
    for (var element in fields) {
      final index = fields.indexOf(element);
      TranslationService.add(signUpData.data()![fields[index]]);
    }
  }
}
