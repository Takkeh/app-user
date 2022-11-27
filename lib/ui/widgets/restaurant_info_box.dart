import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/ui/widgets/custom_svg_icon.dart';
import 'package:takkeh/utils/base/colors.dart';

class RestaurantInfoBox extends StatelessWidget {
  final String text;
  final String? networkIcon, assetIcon;
  final bool isNetwork;

  const RestaurantInfoBox({
    Key? key,
    required this.text,
    this.networkIcon,
    this.isNetwork = false,
    this.assetIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        isNetwork ? CustomSvgIcon(iconUrl: networkIcon!) : SvgPicture.asset(assetIcon!),
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
