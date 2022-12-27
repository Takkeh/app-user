import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/components/guest_dialog.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class GuestUserHelper {
  static late String currentRoute;

  static bool check(String routeName, BuildContext context) {
    if (MySharedPreferences.isLogIn) {
      return true;
    } else {
      GuestDialog().show(routeName, context);
      return false;
    }
  }
}
