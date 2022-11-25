import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/base/images.dart';

class CustomSvgIcon extends StatelessWidget {
  final String reviewIcon;
  final double width;

  const CustomSvgIcon({
    Key? key,
    required this.reviewIcon,
    this.width = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      '${ApiUrl.mainUrl}$reviewIcon',
      width: width,
      placeholderBuilder: (context) {
        return const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(MyImages.logo),
        );
      },
    );
  }
}
