import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:takkeh/utils/base/colors.dart';

class CustomShimmerLoading extends StatelessWidget {
  final double? width;
  final double radius;
  final double? height;

  const CustomShimmerLoading({
    Key? key,
    this.width,
    required this.radius,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MyColors.primary,
      highlightColor: MyColors.primary.withOpacity(0.50),
      child: Container(
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
