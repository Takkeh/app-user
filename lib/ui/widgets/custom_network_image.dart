import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final double radius;
  final double? width;
  final double? height;

  const CustomNetworkImage({
    Key? key,
    required this.url,
    required this.radius,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "${ApiUrl.mainUrl}/$url",
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: MyColors.greyED0,
          borderRadius: BorderRadius.circular(radius),
          image: const DecorationImage(
            image: AssetImage(MyImages.placeHolder),
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          color: MyColors.greyED0,
          borderRadius: BorderRadius.circular(radius),
          image: const DecorationImage(
            image: AssetImage(MyImages.error),
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
