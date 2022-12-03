import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/nav_bar.dart';
import 'package:takkeh/model/restaurants/order_details_model.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/base/nav_bar.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/captain_widget.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_fab_button.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/gradient_colors_box.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/order_address_tile.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/order_status_appbar.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/order_status_text.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/order_time_line.dart';
import 'package:takkeh/utils/base/images.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class OrderStatusScreen extends StatelessWidget {
  final int orderId;
  const OrderStatusScreen({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("data:: ${MySharedPreferences.userId} -- $orderId");
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const BaseNavBar(), binding: NavBarBinding());
        return false;
      },
      child: StreamBuilder<QuerySnapshot<FireOrderDetails>>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('drop_point_id', isEqualTo: MySharedPreferences.userId)
            .where('order_id', isEqualTo: orderId)
            .withConverter<FireOrderDetails>(
              fromFirestore: (snapshot, _) => FireOrderDetails.fromJson(snapshot.data()!),
              toFirestore: (order, _) => order.toJson(),
            )
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(body: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Text('Locaing'));
          }

          final data = snapshot.data!.docs[0].data();
          return Scaffold(
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
                      Center(
                        child: Text("data:: ${data.orderDetailsList[0].name} -- $orderId"),
                      ),
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
                      CaptainWidget(name: data.driverName, imageUrl: data.driverImage),
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
          );
        },
      ),
    );
  }
}
