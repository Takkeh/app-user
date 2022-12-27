import 'package:flutter/material.dart';
import 'package:takkeh/utils/app_constants.dart';

class FailedWidget extends StatelessWidget {
  const FailedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(AppConstants.failedMessage),
    );
  }
}
