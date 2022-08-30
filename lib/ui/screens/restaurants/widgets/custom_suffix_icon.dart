import 'package:flutter/material.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/utils/base/colors.dart';

class CustomSuffixIcon extends StatelessWidget {
  final String icon;
  final Function() onTap;

  const CustomSuffixIcon({
    Key? key,
    required this.icon,
    required this.onTap,
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
            TranslationService.getString('send_key'),
            style: const TextStyle(color: MyColors.primary),
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
