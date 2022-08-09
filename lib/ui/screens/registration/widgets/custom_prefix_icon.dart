import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPrefixIcon extends StatelessWidget {
  final String icon;

  const CustomPrefixIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        SvgPicture.asset(icon),
        const Spacer(),
        const VerticalDivider(
          width: 20,
          indent: 5,
          endIndent: 5,
        ),
      ],
    );
  }
}
