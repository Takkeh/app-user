import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:takkeh/utils/base/colors.dart';

class OverLayLoader {
  static void showLoading(BuildContext context, {Color color = MyColors.primary}) {
    Loader.show(
      context,
      overlayColor: Colors.black26,
      progressIndicator: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
