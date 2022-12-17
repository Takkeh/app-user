import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:takkeh/main.dart';
import 'package:takkeh/model/notifications/notifications_model.dart';
import 'package:takkeh/send_noti_ctrl.dart';
import 'package:takkeh/ui/screens/help/help.dart';
import 'package:takkeh/utils/base/colors.dart';

class LocalNotificationsService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void toggle() {
    log("MyData::: ${notificationsMap['route']}");
    // var myData = NotificationsModel.fromJson(notificationsMap);
    // print("alsfijalsfija:: $myData");
  }

  void initialize() {
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
          try {
            log("notificationsMap:: $notificationsMap");
            // var route = notificationsMap['route'];
            // var id = notificationsMap['id'];
            // var title = notificationsMap['title'];
            // var cost = notificationsMap['cost'];
            // var time = notificationsMap['time'];
            // log("type:: ${notificationsMap.runtimeType}");
            var myList = NotificationsModel.fromJson(notificationsMap);
            print("myList:: $myList");
            if (myList.route == RoutesEnum.restaurant.name) {
              Get.to(() => const HelpScreen());
            }
          } catch (e) {
            print("myError:: $e");
          }
        }
      },
    );
  }

  //for notifications in foreground
  void display(RemoteMessage message) async {
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
