import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/restaurants_home.dart';
import 'package:takkeh/ui/screens/home/widgets/home_image_loading.dart';
import 'package:takkeh/ui/screens/restaurants/restaurants_home.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/utils/app_constants.dart';

class SectionsBuilder extends StatelessWidget {
  const SectionsBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection('categories').orderBy('order').get(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const HomeImageLoading();
          case ConnectionState.done:
          default:
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                            () => const RestaurantsHomeScreen(),
                            binding: RestaurantsHomeBinding(),
                            routeName: AppConstants.restaurantsRouteName,
                          );
                        },
                        child: CustomNetworkImage(
                          boxFit: BoxFit.contain,
                          height: 100,
                          url: snapshot.data!.docs[0].data()['image'],
                          radius: 15,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Fluttertoast.showToast(msg: 'Coming Soon!'.tr);
                        },
                        child: CustomNetworkImage(
                          boxFit: BoxFit.contain,
                          height: 100,
                          url: snapshot.data!.docs[1].data()['image'],
                          radius: 15,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Fluttertoast.showToast(msg: 'Coming Soon!'.tr);
                        },
                        child: CustomNetworkImage(
                          boxFit: BoxFit.contain,
                          height: 100,
                          url: snapshot.data!.docs[2].data()['image'],
                          radius: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              log("error:: ${snapshot.error}");
              return const FailedWidget();
            }
        }
      },
    );
  }
}
