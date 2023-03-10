import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/base/colors.dart';

class CustomSvgIcon extends StatelessWidget {
  final String iconUrl;
  final double? width;
  final Color? color;

  const CustomSvgIcon({
    Key? key,
    required this.iconUrl,
    this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      '${ApiUrl.mainUrl}/$iconUrl',
      width: width,
      color: color,
      placeholderBuilder: (context) {
        return const Icon(
          Icons.image,
          size: 40,
          color: MyColors.redPrimary,
        );
      },
    );
  }
}
