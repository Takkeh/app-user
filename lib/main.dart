import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/nav_bar.dart';
import 'package:takkeh/binding/registration/sign_in.dart';
import 'package:takkeh/services/device_token_service.dart';
import 'package:takkeh/services/notifications/cloud_messaging_service.dart';
import 'package:takkeh/services/notifications/local_notifications_service.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/translation/translation.dart';
import 'package:takkeh/ui/base/internet_screen.dart';
import 'package:takkeh/ui/base/intro.dart';
import 'package:takkeh/ui/base/nav_bar.dart';
import 'package:takkeh/ui/screens/registration/registration.dart';
import 'package:takkeh/utils/material_theme.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

// implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"

Map<String, dynamic> notificationsMap = {};

Future<void> _onBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    final data = message.notification;
    log("onBackgroundMessage::\nTitle:: ${data?.title}\nBody:: ${data?.body}\nData:: ${message.data}");
  }
}

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
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  await MySharedPreferences.init();
  await FirebaseMessaging.instance.getToken().then((value) async {
    MySharedPreferences.deviceToken = value!;
    log("deviceToken:: $value");
    DeviceTokenService.updateDeviceToken(value);
  });
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
  bool internetConnection = true;

  Widget _toggleScreen() {
    if (MySharedPreferences.isLogIn) {
      return const BaseNavBar();
    } else if (!MySharedPreferences.isLogIn && !MySharedPreferences.isPassedIntro) {
      return const IntroScreen();
    } else {
      return const RegistrationScreen();
    }
  }

  Bindings? _initialBinding() {
    if (MySharedPreferences.isLogIn) {
      return NavBarBinding();
    } else if (!MySharedPreferences.isLogIn && !MySharedPreferences.isPassedIntro) {
      return null;
    } else {
      return RegistrationBinding();
    }
  }

  @override
  void initState() {
    Connectivity().onConnectivityChanged.listen((status) {
      log("internetStatus:: $status");
      if (status == ConnectivityResult.none) {
        setState(() {
          internetConnection = false;
        });
      } else {
        setState(() {
          internetConnection = true;
        });
      }
    });

    LocalNotificationsService().initialize();

    FirebaseMessaging.instance.requestPermission().then((value) {});

    //TODO: check if needed for ios
    // FirebaseMessaging.instance.getToken().then((token) {});
    // FirebaseMessaging.instance.getAPNSToken().then((aPNStoken) {});

    FirebaseMessaging.instance.getInitialMessage().then(CloudMessagingService().terminated);
    FirebaseMessaging.onMessage.listen(CloudMessagingService().foreground);
    FirebaseMessaging.onMessageOpenedApp.listen(CloudMessagingService().background);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
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
      home: internetConnection ? _toggleScreen() : const InternetScreen(),
      //home: const IntroScreen(),
    );
  }
}
