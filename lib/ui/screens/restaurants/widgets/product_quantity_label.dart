import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class ProductQuantityLabel extends StatelessWidget {
  final int quantity;
  const ProductQuantityLabel({
    Key? key,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(MySharedPreferences.language == 'ar' ? 0 : math.pi),
      child: Container(
        height: 32,
        width: 32,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: MyColors.redPrimary,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
        ),
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(MySharedPreferences.language == 'ar' ? 0 : math.pi),
          child: Text(
            "X$quantity",
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
