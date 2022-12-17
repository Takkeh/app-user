import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:takkeh/main.dart';
import 'package:takkeh/services/notifications/local_notifications_service.dart';

class CloudMessagingService {
  void terminatedMessages(RemoteMessage? message) {
    if (message == null) return;
    if (message.notification != null && message.data.isNotEmpty) {
      final data = message.notification;
      log("getInitialMessage:: ${message.data}");
      log("getInitialMessage:: ${data!.title}");
      log("getInitialMessage:: ${data.body}");

      final route = message.data["route"];
      final dreamId = message.data["id"];
      log("_route:: $route");
      log("_dreamId:: $dreamId");
      if (route == "dream") {
        // Get.to(() => DisplayDreamScreen(dreamId: int.parse(_dreamId), isAnswered: false));
      } else if (route == "chat") {
        // Get.to(() => ChatScreen(dreamId: int.parse(_dreamId)));
      }
    }
  }

  void foregroundMessages(RemoteMessage? message) {
    if (message == null) return;
    if (message.notification != null) {
      final data = message.notification;
      notificationsMap = message.data;
      log("foregroundMessage::\nTitle:: ${data?.title}\nBody:: ${data?.body}\nData:: ${message.data}");
      LocalNotificationsService().display(message);
    }
  }

  void background(RemoteMessage? message) {
    if (message == null) return;
    if (message.notification != null && message.data.isNotEmpty) {
      final data = message.notification;
      log("backgroundMessage::\nTitle:: ${data?.title}\nBody:: ${data?.body}\nData:: ${message.data}");
      if (message.data['route'] == "restaurant") {
        print("893ur9283r");
        // Get.to(() => DisplayDreamScreen(dreamId: int.parse(_dreamId), isAnswered: false));
      }
      // else if (route == "chat") {
      //   // Get.to(() => ChatScreen(dreamId: int.parse(_dreamId)));
      // }
    }
  }
}
