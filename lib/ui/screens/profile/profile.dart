import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/profile/change_password.dart';
import 'package:takkeh/ui/screens/profile/profile_info.dart';
import 'package:takkeh/ui/widgets/base_switch_slider.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/base/images.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late PageController pageController;
  bool isProfileInfo = true;

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
    return Scaffold(
      backgroundColor: MyColors.blue6FA,
      appBar: TransparentAppBar(title: TranslationService.getString('edit_profile_key')),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 20),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: MyColors.grey070,
                  borderRadius: BorderRadius.circular(17),
                  image: const DecorationImage(
                    image: AssetImage(MyImages.logo),
                  ),
                ),
              ),
              SvgPicture.asset(MyIcons.camera),
            ],
          ),
          BaseSwitchSlider(
            margin: const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
            title1: TranslationService.getString('profile_info_key'),
            title2: TranslationService.getString('password_key'),
            onTap1: () {
              setState(() {
                FocusManager.instance.primaryFocus?.unfocus();
                isProfileInfo = true;
                pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 750),
                  curve: Curves.fastOutSlowIn,
                );
              });
            },
            onTap2: () {
              FocusManager.instance.primaryFocus?.unfocus();
              setState(() {
                isProfileInfo = false;
                pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 750),
                  curve: Curves.fastOutSlowIn,
                );
              });
            },
            isFirst: MySharedPreferences.language == 'en' ? isProfileInfo : !isProfileInfo,
            color: Colors.white,
          ),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: const [
                ProfileInfoScreen(),
                ChangePasswordScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
