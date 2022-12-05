import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/registration/sign_in.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/base/widgets/drawer_app_bar.dart';
import 'package:takkeh/ui/base/widgets/drawer_background_image.dart';
import 'package:takkeh/ui/base/widgets/drawer_list_tile.dart';
import 'package:takkeh/ui/screens/registration/registration.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class GuestDrawer extends StatelessWidget {
  const GuestDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: const DrawerAppBar(),
      body: Stack(
        alignment: Alignment(MySharedPreferences.language == 'en' ? 1 : -1, 1),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(top: 30),
                    children: [
                      DrawerListTile(
                        title: TranslationService.getString('about_us_key'),
                        icon: MyIcons.info,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    MySharedPreferences.clearProfile();
                    Get.deleteAll(force: true);
                    Get.offAll(() => const RegistrationScreen(), binding: RegistrationBinding());
                  },
                  label: Text(
                    TranslationService.getString('sign_in_key'),
                    style: const TextStyle(
                      color: MyColors.text,
                      fontSize: 20,
                    ),
                  ),
                  icon: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(MySharedPreferences.language == 'en' ? math.pi : 0),
                    child: SvgPicture.asset(
                      MyIcons.signOut,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const DrawerBackGroundImage(),
        ],
      ),
    );
  }
}
