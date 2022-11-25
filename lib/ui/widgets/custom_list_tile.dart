import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/ui/widgets/custom_svg_icon.dart';
import 'package:takkeh/utils/base/colors.dart';

class CustomListTile extends StatelessWidget {
  final String imageUrl, title, subTitle, description, reviewIcon;
  final Function() onTap;

  const CustomListTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.onTap,
    required this.reviewIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                    description,
                    style: const TextStyle(
                      color: MyColors.greyEB3,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomSvgIcon(reviewIcon: reviewIcon),
                          const SizedBox(width: 5),
                          Text(
                            subTitle,
                            style: const TextStyle(
                              color: MyColors.greyEB3,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        subTitle,
                        style: const TextStyle(
                          color: MyColors.greyEB3,
                        ),
                      ),
                      Text(
                        subTitle,
                        style: const TextStyle(
                          color: MyColors.greyEB3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
