import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class PhoneSuffixIcon extends StatelessWidget {
  final TextDirection? textDirection;

  const PhoneSuffixIcon({
    Key? key,
    this.textDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: textDirection,
      children: const [
        SizedBox(width: 14),
        Text(
          "+962",
          style: TextStyle(
            color: MyColors.text,
            fontSize: 16,
          ),
          textDirection: TextDirection.ltr,
        ),
        SizedBox(width: 6),
        VerticalDivider(
          width: 10,
          indent: 5,
          endIndent: 5,
        ),
      ],
    );
  }
}
