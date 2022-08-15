import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradientColorsBox extends StatelessWidget {
  const GradientColorsBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -5,
      child: Container(
        height: 136,
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
      ),
    );
  }
}
