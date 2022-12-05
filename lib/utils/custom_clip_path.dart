import 'package:flutter/material.dart';

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // double w = size.width;
    // double h = size.height;

    Path path_1 = Path();
    path_1.moveTo(size.width * -0.0002102607, 0);
    path_1.lineTo(size.width * 0.9972666, 0);
    path_1.cubicTo(size.width * 0.9972666, 0, size.width * 1.121531, size.height * 0.8041610, size.width * 0.9972666, size.height * 0.9629127);
    path_1.cubicTo(size.width * 0.8730025, size.height * 1.121664, size.width * 0.7495795, size.height * 0.6350068, size.width * 0.5002103, size.height * 0.6350068);
    path_1.cubicTo(size.width * 0.2508410, size.height * 0.6350068, size.width * 0.1246846, size.height * 1.121664, size.width * -0.0002102607, size.height * 0.9629127);
    path_1.cubicTo(size.width * -0.1251051, size.height * 0.8041610, size.width * -0.0002102607, 0, size.width * -0.0002102607, 0);
    path_1.close();

    return path_1;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
