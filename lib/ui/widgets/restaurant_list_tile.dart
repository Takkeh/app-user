import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/ui/widgets/restaurant_info_box.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class RestaurantListTile extends StatelessWidget {
  final String imageUrl, title, description, reviewIcon, review, time, cost;
  final int isBusy;
  final Function() onTap;

  const RestaurantListTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onTap,
    required this.reviewIcon,
    required this.review,
    required this.time,
    required this.cost,
    required this.isBusy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isBusy == 0 ? onTap : null,
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
              colorFilter: isBusy == 1 ? ColorFilter.mode(MyColors.grey070.withOpacity(0.50), BlendMode.dstATop) : null,
              child: isBusy == 1
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FittedBox(
                        child: Text(
                          TranslationService.getString('busy_key'),
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : null,
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
                  const SizedBox(height: 6),
                  FittedBox(
                    child: Row(
                      children: [
                        RestaurantInfoBox(
                          assetIcon: MyIcons.getReviewIcon(reviewIcon),
                          text: review,
                        ),
                        const SizedBox(width: 5),
                        RestaurantInfoBox(
                          text: cost,
                          assetIcon: MyIcons.rider,
                        ),
                        const SizedBox(width: 5),
                        RestaurantInfoBox(
                          text: '$time ${'Minute'.tr}',
                          assetIcon: MyIcons.clock,
                        ),
                      ],
                    ),
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
