import 'dart:math';

import 'package:flutter/material.dart';

class CustomScrollviewAppBar extends StatelessWidget {
  const CustomScrollviewAppBar({
    Key? key,
    required this.offset,
  }) : super(key: key);

  final double offset;

  @override
  Widget build(BuildContext context) {
    /// Here we leverage the maxExtent and minExtent properties
    /// of SliverAppBar to define the bounds between which
    /// the SliverAppBar will be animated during scrolling.

    const double maxExtent = 350;
    const double minExtent = 50;

    final double shrinkOffset = offset;

    final expendPercentage = 1.0 - min(1, shrinkOffset / (maxExtent - minExtent));

    final interpolatedBackgroundColor = Color.lerp(
      Colors.blue,
      Colors.green,
      expendPercentage,
    );
    final interpolatedAlignment = Alignment.lerp(
      Alignment.bottomLeft,
      Alignment.centerRight,
      expendPercentage,
    );
    final interpolatedTextStyle = TextStyle.lerp(
      const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: Colors.yellow,
      ),
      expendPercentage,
    );

    return Container(
      height: minExtent + (maxExtent - minExtent) * expendPercentage,
      color: interpolatedBackgroundColor,
      alignment: interpolatedAlignment,
      child: Text(
        'Custom Scrollview Title',
        style: interpolatedTextStyle,
      ),
    );
  }
}
