import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/utils/base/colors.dart';

class RestaurantInfoBox extends StatelessWidget {
  final String text;
  final String? assetIcon;

  const RestaurantInfoBox({
    Key? key,
    required this.text,
    this.assetIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          assetIcon!,
          height: 20,
          width: 18,
        ),
        const SizedBox(width: 3),
        Text(
          text,
          style: const TextStyle(
            color: MyColors.text,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
