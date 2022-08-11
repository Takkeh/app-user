import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class CustomRichText extends StatelessWidget {
  final int underLineNum;
  final List<String> texts;

  const CustomRichText({
    Key? key,
    required this.underLineNum,
    required this.texts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        // text: 'Reset ',
        style: const TextStyle(
          color: MyColors.text,
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
        children: List.generate(texts.length, (index) {
          return TextSpan(
            text: texts[index],
            style: TextStyle(
              color: Colors.transparent,
              decoration: underLineNum == index ? TextDecoration.underline : null,
              decorationColor: MyColors.primary,
              decorationThickness: 2,
              shadows: const [
                Shadow(
                  offset: Offset(0, -8),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
