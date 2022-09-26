import 'package:flutter/material.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_bubble_image.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/gradient_colors_box.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';

class RestaurantInfoScreen extends StatelessWidget {
  final String title, imageUrl;

  const RestaurantInfoScreen({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: TransparentAppBar(title: title),
      body: Column(
        children: [
          Stack(
            children: [
              const GradientColorsBox(
                height: 350,
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CustomBubbleImage(
                    imageUrl: imageUrl,
                  ),
                  const Positioned(
                    bottom: 40,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.red,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircleAvatar(
                          radius: 18,
                        ),
                        SizedBox(width: 100),
                        CircleAvatar(
                          radius: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          // BaseSwitchSlider(
          //   margin: const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
          //   title1: TranslationService.getString('profile_info_key'),
          //   title2: TranslationService.getString('password_key'),
          //   onTap1: () {
          //     setState(() {
          //       FocusManager.instance.primaryFocus?.unfocus();
          //       isProfileInfo = true;
          //       pageController.animateToPage(
          //         0,
          //         duration: const Duration(milliseconds: 750),
          //         curve: Curves.fastOutSlowIn,
          //       );
          //     });
          //   },
          //   onTap2: () {
          //     FocusManager.instance.primaryFocus?.unfocus();
          //     setState(() {
          //       isProfileInfo = false;
          //       pageController.animateToPage(
          //         1,
          //         duration: const Duration(milliseconds: 750),
          //         curve: Curves.fastOutSlowIn,
          //       );
          //     });
          //   },
          //   isFirst: MySharedPreferences.language == 'en' ? isProfileInfo : !isProfileInfo,
          //   color: Colors.white,
          // ),
        ],
      ),
    );
  }
}
