import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/images.dart';

class FailedWidget extends StatelessWidget {
  const FailedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(MyImages.failedImage),
    );
  }
}
