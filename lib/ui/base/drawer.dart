import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/ui/base/widgets/drawer_list_tile.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/base/images.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class BaseDrawer extends StatelessWidget {
  const BaseDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: const TransparentAppBar(
        title: "Menu",
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(10, 50, 0, 30),
                        child: Row(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  margin: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: MyColors.grey070,
                                    borderRadius: BorderRadius.circular(17),
                                    image: const DecorationImage(
                                      image: AssetImage(MyImages.notifications),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -2,
                                  left: -2,
                                  // right: -2,
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 22,
                                    width: 22,
                                    decoration: BoxDecoration(
                                      color: MyColors.primary,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(MySharedPreferences.language == 'en' ? 5 : 0),
                                        topRight: Radius.circular(MySharedPreferences.language == 'ar' ? 5 : 0),
                                        bottomLeft: Radius.circular(MySharedPreferences.language == 'ar' ? 5 : 0),
                                        bottomRight: Radius.circular(MySharedPreferences.language == 'en' ? 5 : 0),
                                      ),
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.all(2),
                                      alignment: Alignment.center,
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        color: MyColors.grey5B7,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(MySharedPreferences.language == 'en' ? 5 : 0),
                                          topRight: Radius.circular(MySharedPreferences.language == 'ar' ? 5 : 0),
                                          bottomLeft: Radius.circular(MySharedPreferences.language == 'ar' ? 5 : 0),
                                          bottomRight: Radius.circular(MySharedPreferences.language == 'en' ? 5 : 0),
                                        ),
                                      ),
                                      child: SvgPicture.asset(MyIcons.edit),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Ahmad",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "+9621765151",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
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
                  onPressed: () {},
                  label: const Text(
                    "  Sign out  ",
                    style: TextStyle(
                      color: MyColors.text,
                      fontSize: 20,
                    ),
                  ),
                  icon: SvgPicture.asset(
                    MyIcons.signOut,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(MyImages.handUpTransparent),
        ],
      ),
    );
  }
}
