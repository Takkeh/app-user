import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class CustomIndicator extends StatelessWidget {
  final int index;
  final int currentWidget;

  const CustomIndicator({
    Key? key,
    required this.index,
    required this.currentWidget,
  }) : super(key: key);

  double _getWidth() {
    if (index == currentWidget) {
      return 20;
    } else {
      return 8;
    }
  }

  Color _getColor() {
    if (index == currentWidget) {
      return MyColors.primary;
    } else {
      return MyColors.grey9F4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      duration: const Duration(milliseconds: 500),
      width: _getWidth(),
      height: 8,
      decoration: BoxDecoration(
        color: _getColor(),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
