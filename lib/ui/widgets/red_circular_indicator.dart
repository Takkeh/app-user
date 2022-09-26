import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class RedCircularProgressIndicator extends StatelessWidget {
  const RedCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.redPrimary,
      ),
    );
  }
}
