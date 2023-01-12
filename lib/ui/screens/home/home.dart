import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:takkeh/controller/nav_bar_ctrl.dart';
import 'package:takkeh/model/restaurants/order_details_model.dart';
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
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final finished = [
    kCompleted,
    kCanceled,
    kCanceled0,
    kDenied,
  ];

  Widget _getOrderBox(AsyncSnapshot<QuerySnapshot<FireOrderDetails>> snapshot) {
    if (snapshot.hasError) {
      return const SizedBox.shrink();
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const SizedBox.shrink();
    }

    if (snapshot.data!.docs.isEmpty) {
      return const SizedBox.shrink();
    }

    final data = snapshot.data!.docs[0].data();
    return OrderFABButton(data: data);
  }

  double _togglePadding(AsyncSnapshot<QuerySnapshot<FireOrderDetails>> snapshot) {
    if (snapshot.hasError) {
      return 30.0;
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return 30.0;
    }

    if (snapshot.data!.docs.isEmpty) {
      return 30.0;
    }

    return 120.0;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('drop_point_id', isEqualTo: MySharedPreferences.userId)
            .where('status', whereNotIn: finished)
            .orderBy('status')
            .orderBy('created_at', descending: true)
            .withConverter<FireOrderDetails>(
              fromFirestore: (snapshot, _) => FireOrderDetails.fromJson(snapshot.data()!),
              toFirestore: (order, _) => order.toJson(),
            )
            .snapshots(),
        builder: (context, snapshot) {
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: _getOrderBox(snapshot),
            onDrawerChanged: (isOpen) {
              NavBarCtrl.find.toggle(isOpen);
            },
            drawer: MySharedPreferences.isLogIn ? const BaseDrawer() : const GuestDrawer(),
            appBar: const HomeAppBar(),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: _togglePadding(snapshot)),
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
                  Visibility(
                    visible: false,
                    child: ElevatedButton(
                      onPressed: () {
                        // SendNotificationsCtrl().send();
                      },
                      child: const Text("Send"),
                    ),
                  ),
                  const SectionsBuilder(),
                  TitleWidget(title: TranslationService.getString('takkeh_offers_key')),
                  const TakkehOffersBuilder(),
                  TitleWidget(title: TranslationService.getString('special_offers_key')),
                  const SpecialOffersBuilder(),
                ],
              ),
            ),
          );
        });
  }
}
