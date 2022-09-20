import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class CustomSuffixIcon extends StatelessWidget {
  final String icon;
  final String title;
  final Function() onTap;

  const CustomSuffixIcon({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const VerticalDivider(
          width: 20,
          indent: 5,
          endIndent: 5,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            title,
            style: const TextStyle(color: MyColors.redPrimary),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
