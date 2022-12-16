import 'dart:developer';

import 'package:takkeh/main.dart';
import 'package:takkeh/services/notifications/local_notifications_service.dart';

class CloudMessagingService {
  static final localNotificationsService = LocalNotificationsService();

  static void terminatedMessages(message) {
    if (message?.notification != null && message!.data.isNotEmpty) {
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

  static void foregroundMessages(message) {
    if (message.notification != null) {
      final data = message.notification;
      log("_data:: $data");
      log("onMessage:: ${message.data}");
      log("onMessage:: ${data?.title}");
      log("onMessage:: ${data?.body}");
      notificationsMap = message.data;
      log("onMessage:: $notificationsMap");
      LocalNotificationsService.display(message);
    }
  }

  static void background(message) {
    if (message.notification != null && message.data.isNotEmpty) {
      final data = message.notification;
      log("onMessageOpenedApp:: ${message.data}");
      log("onMessageOpenedApp:: ${data?.title}");
      log("onMessageOpenedApp:: ${data?.body}");
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
}
