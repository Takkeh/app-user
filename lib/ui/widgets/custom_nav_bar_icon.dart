import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/utils/base/colors.dart';

class CustomNavBaaButton extends StatelessWidget {
  final String icon;
  final bool isChosen;

  const CustomNavBaaButton({
    Key? key,
    required this.icon,
    required this.isChosen,
  }) : super(key: key);

  static Color _toggleColor(bool isChosen) {
    if (isChosen) {
      return MyColors.redPrimary;
    } else {
      return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5.0),
            padding: const EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              color: _toggleColor(isChosen),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              icon,
              color: Colors.white,
              height: 24,
              width: 24,
            ),
          ),
        ),
        if (isChosen)
          const CircleAvatar(
            radius: 3,
            backgroundColor: Colors.white,
          ),
      ],
    );
  }
}
