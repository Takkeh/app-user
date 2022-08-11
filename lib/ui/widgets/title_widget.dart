import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Image.asset(
            MyImages.handEn,
            height: 30,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: MyColors.black333,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
