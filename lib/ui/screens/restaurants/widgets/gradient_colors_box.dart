import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradientColorsBox extends StatelessWidget {
  final double height;

  const GradientColorsBox({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
