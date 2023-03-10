import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/utils/base/colors.dart';

class CustomPrefixIcon extends StatelessWidget {
  final String icon;
  final TextDirection? textDirection;

  const CustomPrefixIcon({
    Key? key,
    required this.icon,
    this.textDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: textDirection,
      children: [
        const SizedBox(width: 20),
        SvgPicture.asset(icon),
        const Spacer(),
        const VerticalDivider(
          width: 20,
          indent: 5,
          endIndent: 5,
          color: MyColors.grey9F4,
        ),
      ],
    );
  }
}
