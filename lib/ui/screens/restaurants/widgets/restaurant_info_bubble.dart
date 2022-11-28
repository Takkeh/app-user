import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/restauratns_info.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/restaurants/restaurant_info.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class RestaurantInfoBubble extends StatelessWidget {
  final String title, logo, time, cost, review, cover, reviewIcon;
  final int restaurantId;

  const RestaurantInfoBubble({
    Key? key,
    required this.title,
    required this.logo,
    required this.time,
    required this.cost,
    required this.review,
    required this.cover,
    required this.restaurantId,
    required this.reviewIcon,
  }) : super(key: key);

  static Widget getWidget(String text, String icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(icon),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 220,
      color: Colors.transparent,
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: const Alignment(0, 0),
            child: GestureDetector(
              onTap: () {
                Get.to(
                  () => RestaurantInfoScreen(
                    title: title,
                    imageUrl: cover,
                    logo: logo,
                    restaurantId: restaurantId,
                  ),
                  binding: RestaurantInfoBinding(),
                );
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CircleAvatar(
                    backgroundColor: MyColors.redPrimary,
                    radius: 50,
                    backgroundImage: CachedNetworkImageProvider('${ApiUrl.mainUrl}/$logo'),
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        bottom: -1,
                        child: SvgPicture.asset(
                          MyIcons.halfCircle,
                          width: 85,
                        ),
                      ),
                      Container(
                        width: 57,
                        color: Colors.transparent,
                        margin: const EdgeInsets.only(bottom: 7),
                        padding: const EdgeInsets.only(top: 0),
                        child: FittedBox(
                          child: Text(
                            TranslationService.getString('information_key'),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            child: SizedBox(
              width: 220,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getWidget('$time ${'Minute'.tr}', MyIcons.clock),
                  getWidget(cost, MyIcons.rider),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  MyIcons.getReviewIcon(reviewIcon),
                  height: 20,
                  width: 18,
                ),
                const SizedBox(width: 5),
                Text(
                  review,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
