import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:takkeh/main.dart';
import 'package:takkeh/model/notifications/notifications_model.dart';
import 'package:takkeh/ui/screens/help/help.dart';
import 'package:takkeh/utils/base/colors.dart';

class LocalNotificationsService {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@drawable/notifications_icon'),
      iOS: DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
      ),
    );
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (message) {
        if (notificationsMap.isNotEmpty) {
          var myData = NotificationsModel.fromJson(notificationsMap);
          // print("result:: ${myData.notification!.title}");
          log("resultttt:: message:: $message notificationsMap:: $notificationsMap");
          log("onSelectNotification:: message:: $message notificationsMap:: $notificationsMap");
          if (myData.data!.route == 'restaurant') {
            Get.to(() => const HelpScreen());
          }
        }
      },
    );
  }

  //for notifications in foreground
  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'takkehchannel', // id
        'Takkeh channel', // title
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
        playSound: true,
      );

      await _flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: Importance.max,
            playSound: true,
            icon: '@drawable/notifications_icon',
            color: MyColors.primary,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: message.data["route"],
      );
    } on Exception catch (e) {
      log("Exception:: $e");
    }
  }
}
