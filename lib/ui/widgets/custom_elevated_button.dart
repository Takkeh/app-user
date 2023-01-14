import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final double height;
  final double width;
  final double radius;
  final Color? color;
  final Color? textColor;
  final bool isFittedBox;
  final EdgeInsetsGeometry? padding;

  const CustomElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.height = 54,
    this.width = 160,
    this.color,
    this.textColor = MyColors.black109,
    this.radius = 23,
    this.padding,
    this.isFittedBox = false,
  }) : super(key: key);

  Widget _getTextWidget() {
    return Text(
      title,
      style: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          fixedSize: Size(width, height),
          elevation: 0,
        ),
        child: isFittedBox
            ? FittedBox(
                child: _getTextWidget(),
              )
            : _getTextWidget(),
      ),
    );
  }
}
