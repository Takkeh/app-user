import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_bubble_image.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/gradient_colors_box.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/restaurants_info_builder.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/restaurants_reviews_builder.dart';
import 'package:takkeh/ui/widgets/base_switch_slider.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class RestaurantInfoScreen extends StatefulWidget {
  final String title, imageUrl, logo;

  const RestaurantInfoScreen({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.logo,
  }) : super(key: key);

  @override
  State<RestaurantInfoScreen> createState() => _RestaurantInfoScreenState();
}

class _RestaurantInfoScreenState extends State<RestaurantInfoScreen> {
  late PageController pageController;
  bool isInformation = true;
  int currentIndex = 0;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var distance = (Get.width - 60.0) / 4;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TransparentAppBar(title: widget.title),
      body: Column(
        children: [
          Stack(
            children: [
              const GradientColorsBox(
                margin: EdgeInsets.only(top: 130),
                height: 215,
              ),
              Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      CustomBubbleImage(
                        imageUrl: widget.imageUrl,
                      ),
                      Positioned(
                        bottom: 15,
                        child: CustomNetworkImage(
                          radius: 100,
                          height: 100,
                          width: 100,
                          url: widget.logo,
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: distance + 9),
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 18,
                                child: SvgPicture.asset(MyIcons.phoneGreen),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 18,
                                child: SvgPicture.asset(MyIcons.emojiLove),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  BaseSwitchSlider(
                    margin: const EdgeInsets.only(top: 30, bottom: 20, left: 30, right: 30),
                    title1: TranslationService.getString('information_key'),
                    title2: TranslationService.getString('reviews_key'),
                    onTap1: () {
                      setState(() {
                        isInformation = true;
                        pageController.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastOutSlowIn,
                        );
                      });
                    },
                    onTap2: () {
                      setState(() {
                        isInformation = false;
                        pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastOutSlowIn,
                        );
                      });
                    },
                    isFirst: MySharedPreferences.language == 'en' ? isInformation : !isInformation,
                    color: Colors.white,
                    buttonColor: MyColors.redPrimary,
                    textColor1: currentIndex == 0 ? Colors.white : MyColors.black109,
                    textColor2: currentIndex == 0 ? MyColors.black109 : Colors.white,
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                const RestaurantsInfoBuilder(),
                RestaurantsReviewsBuilder(imageUrl: widget.imageUrl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
