import 'package:get/get.dart';
import 'package:takkeh/controller/notification/notification_ctrl.dart';

class NotificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> NotificationCtrl());
  }

}