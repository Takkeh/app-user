import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class CustomFABButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final EdgeInsetsGeometry? padding;

  const CustomFABButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              11,
            ),
          ),
          backgroundColor: MyColors.redPrimary,
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
