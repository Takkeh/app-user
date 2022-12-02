import 'package:get/get.dart';
import 'package:takkeh/controller/user_location_ctrl.dart';
import 'package:takkeh/ui/screens/addresses/location_permission_screen.dart';

class LocationPermissionHelper {
  static void check({required Function action}) {
    if (UserLocationCtrl.find.deniedPermissions.contains(UserLocationCtrl.find.permission.value)) {
      Get.to(() => const LocationPermissionScreen())!.then((value) {
        if (!UserLocationCtrl.find.deniedPermissions.contains(UserLocationCtrl.find.permission.value)) {
          action();
        }
      });
    } else {
      action();
    }
  }
}
