import 'package:get/get.dart';
import 'package:takkeh/translation/arabic.dart';
import 'package:takkeh/translation/english.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en": en,
        "ar": arabicKeys,
      };
}
