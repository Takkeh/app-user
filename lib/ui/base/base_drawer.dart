import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/registration/sign_in.dart';
import 'package:takkeh/binding/wallet/wallet_binding.dart';
import 'package:takkeh/controller/registration/log_out.dart';
import 'package:takkeh/helper/location_permission_helper.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/base/widgets/drawer_app_bar.dart';
import 'package:takkeh/ui/base/widgets/drawer_background_image.dart';
import 'package:takkeh/ui/base/widgets/drawer_list_tile.dart';
import 'package:takkeh/ui/base/widgets/drawer_profile_info.dart';
import 'package:takkeh/ui/screens/addresses/my_addresses_screen.dart';
import 'package:takkeh/ui/screens/help/help.dart';
import 'package:takkeh/ui/screens/my_orders/my_orders.dart';
import 'package:takkeh/ui/screens/profile/profile.dart';
import 'package:takkeh/ui/screens/registration/registration.dart';
import 'package:takkeh/ui/screens/wallet/wallet.dart';
import 'package:takkeh/ui/widgets/components/language_dialog.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

enum LanguageEnum { english, arabic }

class BaseDrawer extends StatefulWidget {
  const BaseDrawer({Key? key}) : super(key: key);

  @override
  State<BaseDrawer> createState() => _BaseDrawerState();
}

class _BaseDrawerState extends State<BaseDrawer> {
  @override
  void initState() {
    Get.lazyPut(() => LogOutController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<LogOutController>();
    super.dispose();
  }

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
                      Opacity(
                        opacity: MySharedPreferences.accessToken.isEmpty ? 0.0 : 1.0,
                        child: const DrawerProfileInfo(),
                      ),
                      DrawerListTile(
                        title: TranslationService.getString('profile_key'),
                        icon: MyIcons.user,
                        onTap: () {
                          Get.to(() => const ProfileScreen(withBackButton: true,));
                        },
                      ),
                      DrawerListTile(
                        title: TranslationService.getString('orders_key'),
                        icon: MyIcons.timePast,
                        onTap: () {
                          Get.to(() => const MyOrdersScreen(withBackButton: true,));
                        },
                      ),
                      DrawerListTile(
                        title: TranslationService.getString('my_addresses_key'),
                        icon: MyIcons.wallet,
                        onTap: () {
                          LocationPermissionHelper.check(
                            action: () {
                              Get.to(() => const MyAddressesScreen());
                            },
                          );
                        },
                      ),
                      DrawerListTile(
                        title: TranslationService.getString('wallet_key'),
                        icon: MyIcons.wallet,
                        onTap: () {
                          Get.to(() => const WalletScreen(), binding: WalletBinding());
                        },
                      ),
                      DrawerListTile(
                        title: TranslationService.getString('cards_key'),
                        icon: MyIcons.ticketBlack,
                        onTap: () {},
                      ),
                      DrawerListTile(
                        title: TranslationService.getString('language_key'),
                        icon: MyIcons.language,
                        onTap: () {
                          LanguageDialog().show();
                        },
                      ),
                      DrawerListTile(
                        title: TranslationService.getString('help_key'),
                        icon: MyIcons.questionMark,
                        onTap: () {
                          Get.to(() => const HelpScreen(withBackButton: true,));
                        },
                      ),
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
                    // LogOutController.find.fetchLogOutData(context);
                  },
                  label: Text(
                    TranslationService.getString('sign_out_key'),
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
