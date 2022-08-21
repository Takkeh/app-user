import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/controller/registration/log_out.dart';
import 'package:takkeh/ui/base/widgets/drawer_app_bar.dart';
import 'package:takkeh/ui/base/widgets/drawer_background_image.dart';
import 'package:takkeh/ui/base/widgets/drawer_list_tile.dart';
import 'package:takkeh/ui/base/widgets/drawer_profile_info.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class BaseDrawer extends StatelessWidget {
  const BaseDrawer({Key? key}) : super(key: key);

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
                    children: [
                      const DrawerProfileInfo(),
                      DrawerListTile(
                        title: 'Profile',
                        icon: MyIcons.user,
                        onTap: () {},
                      ),
                      DrawerListTile(
                        title: 'Orders',
                        icon: MyIcons.timePast,
                        onTap: () {},
                      ),
                      DrawerListTile(
                        title: 'Wallet',
                        icon: MyIcons.wallet,
                        onTap: () {},
                      ),
                      DrawerListTile(
                        title: 'Cards',
                        icon: MyIcons.ticketBlack,
                        onTap: () {},
                      ),
                      DrawerListTile(
                        title: 'Help',
                        icon: MyIcons.questionMark,
                        onTap: () {},
                      ),
                      DrawerListTile(
                        title: 'About',
                        icon: MyIcons.info,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    LogOutController.fetchLogOutData(context);
                  },
                  label: const Text(
                    "  Sign out  ",
                    style: TextStyle(
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
