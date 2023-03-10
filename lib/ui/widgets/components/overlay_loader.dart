import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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

  static void flickrLoading(BuildContext context, {Color color = MyColors.primary}) {
    Loader.show(
      isAppbarOverlay: true,
      context,
      progressIndicator: Center(
        child: LoadingAnimationWidget.flickr(
          leftDotColor: MyColors.text,
          rightDotColor: MyColors.redPrimary,
          size: 50,
        ),
      ),
    );
  }
}
