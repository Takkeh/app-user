import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/utils/base/colors.dart';

class PhoneSuffixIcon extends StatelessWidget {
  const PhoneSuffixIcon({
    Key? key,
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
        Text(
          "+962".tr,
          style: const TextStyle(
            color: MyColors.text,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
