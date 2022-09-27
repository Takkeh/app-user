import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradientColorsBox extends StatelessWidget {
  final double height;
  final EdgeInsetsGeometry? margin;

  const GradientColorsBox({
    Key? key,
    required this.height,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: Get.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFAC21C).withOpacity(0.40),
            Colors.white.withOpacity(0.40),
          ],
        ),
      ),
    );
  }
}
