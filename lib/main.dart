import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/nav_bar.dart';
import 'package:takkeh/binding/registration/sign_in.dart';
import 'package:takkeh/print_test.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/translation/translation.dart';
import 'package:takkeh/ui/base/intro.dart';
import 'package:takkeh/ui/base/nav_bar.dart';
import 'package:takkeh/ui/screens/registration/registration.dart';
import 'package:takkeh/utils/material_theme.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

// implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //   apiKey: "XXX",
      //   appId: "XXX",
      //   messagingSenderId: "XXX",
      //   projectId: "XXX",
      // ),
      );
  await MySharedPreferences.init();
  MySharedPreferences.language = "";
  if (MySharedPreferences.language.isEmpty) {
    // MySharedPreferences.language = Get.deviceLocale!.languageCode;
    MySharedPreferences.language = 'ar';
  }
  await TranslationService.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _toggleScreen() {
    if (MySharedPreferences.isLogIn && MySharedPreferences.accessToken.isNotEmpty) {
      return const BaseNavBar();
    } else if (!MySharedPreferences.isLogIn && !MySharedPreferences.isPassedIntro) {
      return const IntroScreen();
    } else {
      return const RegistrationScreen();
    }
  }

  Bindings _initialBinding() {
    //TODO: test and edit
    if (MySharedPreferences.isLogIn) {
      return NavBarBinding();
    } else {
      // return SignInBinding();
      return SignInBinding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: _initialBinding(),
      translations: Translation(),
      // localizationsDelegates: GlobalMaterialLocalizations.delegates,
      // supportedLocales: const [
      //   Locale('en', 'US'),
      //   Locale('ar', 'JO'),
      // ],
      // locale: Locale(MySharedPreferences.language),
      locale: Locale(MySharedPreferences.language),
      fallbackLocale: Locale(MySharedPreferences.language),
      theme: AppThemeData().materialTheme,
      // home: _toggleScreen(),
      home: PrintTest(),
    );
  }
}
