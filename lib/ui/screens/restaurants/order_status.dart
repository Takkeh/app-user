import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/nav_bar.dart';
import 'package:takkeh/model/restaurants/order_details_model.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/base/nav_bar.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_fab_button.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/gradient_colors_box.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/order_address_tile.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/order_status_appbar.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/order_status_text.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/order_time_line.dart';
import 'package:takkeh/utils/base/images.dart';

class OrderStatusScreen extends StatelessWidget {
  final int orderId;
  const OrderStatusScreen({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  static final moviesRef = FirebaseFirestore.instance.collection('orders').withConverter<FireOrderDetails>(
        fromFirestore: (snapshot, _) => FireOrderDetails.fromJson(snapshot.data()!),
        toFirestore: (order, _) => order.toJson(),
      );

  static Widget myWidget() {
    return StreamBuilder<QuerySnapshot<FireOrderDetails>>(
      stream: moviesRef.snapshots(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Text(snapshot.data!.docs[0].data().userAddress);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const BaseNavBar(), binding: NavBarBinding());
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: CustomFABButton(
            title: TranslationService.getString("go_to_home_screen_key"),
            onPressed: () {
              Get.offAll(() => const BaseNavBar(), binding: NavBarBinding());
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        appBar: OrderStatusAppBar(orderId: orderId),
        body: Column(
          children: [
            const GradientColorsBox(height: 136),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                children: [
                  Image.asset(MyImages.driver),
                  const SizedBox(height: 20),
                  const OrderStatusText(),
                  const OrderTimeLine(),
                  const Divider(
                    height: 30,
                    indent: 15,
                    endIndent: 15,
                  ),
                  const OrderAddressTile(),
                  const Divider(
                    height: 30,
                    indent: 15,
                    endIndent: 15,
                  ),
                  // CaptainWidget(name: UpdateOrderCtrl.model!.data!.driverName!),
                  const Divider(
                    height: 30,
                    indent: 15,
                    endIndent: 15,
                  ),
                  Text(
                    TranslationService.getString('order_details_key'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // OrderDetailsWidget(productName: UpdateOrderCtrl.model!.data!.products!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
