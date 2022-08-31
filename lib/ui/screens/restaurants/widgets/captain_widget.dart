import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/base/images.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class CaptainWidget extends StatelessWidget {
  const CaptainWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(13),
      color: const Color(0xFFFFFEFB),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomNetworkImage(
            url: 'https://image.shutterstock.com/image-photo/profile-picture-smiling-millennial-asian-260nw-1836020740.jpg',
            radius: 10,
            height: 80,
            width: 80,
          ),
          const SizedBox(width: 13),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "captain_name_key",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "captian name",
                style: TextStyle(fontSize: 18),
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
