import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:takkeh/controller/nav_bar_ctrl.dart';
import 'package:takkeh/ui/screens/help/help.dart';
import 'package:takkeh/ui/screens/home/home.dart';
import 'package:takkeh/ui/screens/my_orders/my_orders.dart';
import 'package:takkeh/ui/screens/profile/profile.dart';
import 'package:takkeh/ui/widgets/components/guest_dialog.dart';
import 'package:takkeh/ui/widgets/custom_nav_bar_icon.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

bool isHidden = false;

late PersistentTabController navBarController;

class BaseNavBar extends StatefulWidget {
  const BaseNavBar({Key? key}) : super(key: key);

  @override
  State<BaseNavBar> createState() => BaseNavBarState();
}

class BaseNavBarState extends State<BaseNavBar> {
  void toggleGuestUser(int index) {
    if (MySharedPreferences.isLogIn) {
      navBarController.index = index;
    } else {
      GuestDialog.show(context);
    }
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: CustomNavBaaButton(icon: MyIcons.home, isChosen: navBarController.index == 0 ? true : false),
      ),
      PersistentBottomNavBarItem(
        onPressed: (value) {
          toggleGuestUser(1);
        },
        icon: CustomNavBaaButton(icon: MyIcons.timePast, isChosen: navBarController.index == 1 ? true : false),
      ),
      PersistentBottomNavBarItem(
        onPressed: (value) {
          toggleGuestUser(2);
        },
        icon: CustomNavBaaButton(icon: MyIcons.headset, isChosen: navBarController.index == 2 ? true : false),
      ),
      PersistentBottomNavBarItem(
        onPressed: (value) {
          toggleGuestUser(3);
        },
        icon: CustomNavBaaButton(icon: MyIcons.user, isChosen: navBarController.index == 3 ? true : false),
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const MyOrdersScreen(),
      const HelpScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  void initState() {
    navBarController = PersistentTabController(initialIndex: 0);
    navBarController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarCtrl>(builder: (controller) {
      return PersistentTabView(
        context,
        controller: navBarController,
        screens: _buildScreens(),
        items: _navBarsItems(),
        hideNavigationBar: false,
        confineInSafeArea: true,
        navBarHeight: controller.isHidden.value ? 0 : 70,
        backgroundColor: MyColors.primary, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: const NavBarDecoration(
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
      );
    });
  }
}
