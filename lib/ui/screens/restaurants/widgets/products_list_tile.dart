import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class ProductsListTile extends StatelessWidget {
  final String imageUrl, title, subTitle;
  final int price;
  final Function() onTap;

  const ProductsListTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.onTap,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: MySharedPreferences.language == 'en' ? Alignment.bottomRight : Alignment.bottomLeft,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              color: const Color(0xFFFAF5E6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomNetworkImage(
                  url: imageUrl,
                  radius: 10,
                  width: 80,
                  height: 80,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: MyColors.text,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        subTitle,
                        style: const TextStyle(
                          color: MyColors.greyEB3,
                        ),
                      ),
                      Text(
                        "$price $kPCurrency",
                        style: const TextStyle(
                          color: MyColors.redD4F,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(MySharedPreferences.language == 'ar' ? 0 : math.pi),
            child: Container(
              height: 32,
              width: 32,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: MyColors.redD4F,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(MySharedPreferences.language == 'ar' ? 0 : math.pi),
                child: const Text(
                  "X2",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
