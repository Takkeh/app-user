import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/registration/sign_in.dart';
import 'package:takkeh/ui/screens/registration/registration.dart';
import 'package:takkeh/utils/app_constants.dart';

class GuestDialog {
  static Future<void> show(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('This is a demo alert dialog.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Get.to(() => const RegistrationScreen(route: kBack), binding: RegistrationBinding());
              },
            ),
          ],
        );
      },
    );
  }
}
