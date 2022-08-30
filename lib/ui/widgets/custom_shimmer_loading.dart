import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:takkeh/utils/base/colors.dart';

class CustomShimmerLoading extends StatelessWidget {
  final double? width;
  final double radius;
  final double? height;
  final EdgeInsets? padding;
  final Color highlightColor;

  const CustomShimmerLoading({
    Key? key,
    this.width,
    required this.radius,
    this.height,
    this.highlightColor = MyColors.primary,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MyColors.greyED0,
      highlightColor: highlightColor,
      child: Container(
        padding: padding,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
