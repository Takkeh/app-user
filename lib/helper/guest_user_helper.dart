import 'package:takkeh/ui/widgets/components/guest_dialog.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class GuestUserHelper {
  static bool check() {
    if (MySharedPreferences.isLogIn) {
      return true;
    } else {
      GuestDialog.show();
      return false;
    }
  }
}
