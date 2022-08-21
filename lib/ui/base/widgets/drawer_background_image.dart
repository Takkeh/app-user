import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/images.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class DrawerBackGroundImage extends StatelessWidget {
  const DrawerBackGroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(MySharedPreferences.language == 'en' ? math.pi : 0),
        child: Image.asset(
          MyImages.handUpTransparent,
          color: Colors.white.withOpacity(0.20),
          height: 250,
        ),
      ),
    );
  }
}
