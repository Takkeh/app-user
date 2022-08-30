import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final double height;
  final double width;
  final Color? color;

  const CustomElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.height = 54,
    this.width = 160,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
        ),
        fixedSize: Size(width, height),
        elevation: 0,
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: MyColors.black109,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
