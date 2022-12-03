import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/base/images.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class CaptainWidget extends StatelessWidget {
  final String name, imageUrl;

  const CaptainWidget({
    Key? key,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      color: const Color(0xFFFFFEFB),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImage(
            url: imageUrl,
            radius: 10,
            height: 80,
            width: 80,
          ),
          const SizedBox(width: 13),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TranslationService.getString("captain_name_key"),
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                name,
                style: const TextStyle(fontSize: 18, color: MyColors.primary),
              ),
            ],
          ),
          const Spacer(),
          Center(
            child: Transform(
              alignment: Alignment.center,
              transform: MySharedPreferences.language == 'en' ? Matrix4.rotationY(pi) : Matrix4.rotationY(0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    MyImages.halfCircleHorizontal,
                    height: 70,
                    width: 33,
                  ),
                  SvgPicture.asset(MyIcons.phoneCall),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
