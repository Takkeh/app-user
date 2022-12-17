import 'package:flutter/material.dart';
import 'package:takkeh/controller/nav_bar_ctrl.dart';
import 'package:takkeh/send_noti_ctrl.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/base/base_drawer.dart';
import 'package:takkeh/ui/base/guest_drawer.dart';
import 'package:takkeh/ui/screens/home/widgets/home_app_bar.dart';
import 'package:takkeh/ui/screens/home/widgets/home_header.dart';
import 'package:takkeh/ui/screens/home/widgets/order_fab_button.dart';
import 'package:takkeh/ui/screens/home/widgets/sections_builder.dart';
import 'package:takkeh/ui/screens/home/widgets/slider_builder.dart';
import 'package:takkeh/ui/screens/home/widgets/special_offers_builder.dart';
import 'package:takkeh/ui/screens/home/widgets/takkah_offers_builder.dart';
import 'package:takkeh/ui/widgets/title_widget.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const OrderFABButton(),
      onDrawerChanged: (isOpen) {
        NavBarCtrl.find.toggle(isOpen);
      },
      drawer: MySharedPreferences.isLogIn ? const BaseDrawer() : const GuestDrawer(),
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: const [
                HomeHeader(),
                SliderBuilder(),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                SendNotificationsCtrl().send();
              },
              child: const Text("Send"),
            ),
            const SectionsBuilder(),
            TitleWidget(
              title: TranslationService.getString('takkeh_offers_key'),
            ),
            const TakkehOffersBuilder(),
            TitleWidget(
              title: TranslationService.getString('special_offers_key'),
            ),
            const SpecialOffersBuilder(),
          ],
        ),
      ),
    );
  }
}
