import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:takkeh/binding/nav_bar.dart';
import 'package:takkeh/model/restaurants/order_details_model.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/base/nav_bar.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/captain_search_box.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/captain_widget.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_fab_button.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/gradient_colors_box.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/order_address_tile.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/order_status_appbar.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/order_status_text.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/order_time_line.dart';
import 'package:takkeh/ui/widgets/order_details_box.dart';
import 'package:takkeh/ui/widgets/order_item.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class OrderStatusScreen extends StatelessWidget {
  final int orderId;
  final String route;

  const OrderStatusScreen({
    Key? key,
    required this.orderId,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: route == kBack
          ? null
          : () async {
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
              if (route == kBack) {
                Get.back();
              } else {
                Get.offAll(() => const BaseNavBar(), binding: NavBarBinding());
              }
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        appBar: OrderStatusAppBar(orderId: orderId),
        body: StreamBuilder<QuerySnapshot<FireOrderDetails>>(
            stream: FirebaseFirestore.instance
                .collection('orders')
                .where('drop_point_id', isEqualTo: MySharedPreferences.userId)
                .where('order_id', isEqualTo: orderId)
                .withConverter<FireOrderDetails>(
                  fromFirestore: (snapshot, _) => FireOrderDetails.fromJson(snapshot.data()!),
                  toFirestore: (order, _) => order.toJson(),
                )
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: LoadingAnimationWidget.flickr(
                    leftDotColor: MyColors.text,
                    rightDotColor: MyColors.redPrimary,
                    size: 50,
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: Text('Loading'));
              }

              final data = snapshot.data!.docs[0].data();
              return Column(
                children: [
                  const GradientColorsBox(height: 136),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 90),
                      children: [
                        Image.asset(MyImages.driver),
                        const SizedBox(height: 20),
                        const OrderStatusText(),
                        OrderTimeLine(status: data.status),
                        const Divider(
                          height: 30,
                          indent: 15,
                          endIndent: 15,
                        ),
                        OrderAddressTile(address: data.dropPointAddress),
                        const Divider(
                          height: 30,
                          indent: 15,
                          endIndent: 15,
                        ),
                        data.driverId == 0 ? const CaptainSearchBox() : CaptainWidget(name: data.driverName, imageUrl: data.driverImage, phoneNum: data.driverPhone),
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
                        ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(height: 15),
                          padding: const EdgeInsets.only(top: 15.0),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.orderDetailsList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final info = data.orderDetailsList[index];
                            return OrderItem(
                              count: info.quantity,
                              price: info.price,
                              title: info.name,
                            );
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                          child: Divider(thickness: 1.2),
                        ),
                        FullOrderDetailsBox(
                          total: data.totalPrice,
                          tax: data.tax,
                          paymentMethod: data.paymentMethod,
                          discount: data.discount,
                          deliveryFee: data.deliveryFee,
                          finalPrice: data.finalPrice,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}