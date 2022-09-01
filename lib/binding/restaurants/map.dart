import 'package:get/get.dart';
import 'package:takkeh/controller/map.dart';

class MapBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapController());
  }
}
