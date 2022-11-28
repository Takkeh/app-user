import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/restaurants_home.dart';
import 'package:takkeh/controller/home/category.dart';
import 'package:takkeh/controller/home/slider.dart';
import 'package:takkeh/controller/nav_bar_ctrl.dart';
import 'package:takkeh/controller/restaurants/make_order.dart';
import 'package:takkeh/controller/user_location_ctrl.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/base/drawer.dart';
import 'package:takkeh/ui/screens/home/widgets/home_app_bar.dart';
import 'package:takkeh/ui/screens/home/widgets/home_header.dart';
import 'package:takkeh/ui/screens/home/widgets/home_image_loading.dart';
import 'package:takkeh/ui/screens/home/widgets/slider_builder.dart';
import 'package:takkeh/ui/screens/home/widgets/special_offers_builder.dart';
import 'package:takkeh/ui/screens/home/widgets/takkah_offers_builder.dart';
import 'package:takkeh/ui/screens/restaurants/restaurants_home.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/ui/widgets/title_widget.dart';
import 'package:takkeh/utils/base/images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 2;
  final images = [
    MyImages.restaurants,
    MyImages.restaurants,
    MyImages.restaurants,
  ];

  @override
  void initState() {
    Get.put(SliderController());
    Get.put(CategoriesController());
    Get.put(UserOrderCtrl(), permanent: true);
    Get.put(UserLocationCtrl(), permanent: true);
    //TODO: change location of this
    Get.put(MakeOrderCtrl(), permanent: true);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<SliderController>();
    Get.delete<CategoriesController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      onDrawerChanged: (isOpen) {
        NavBarCtrl.find.toggle(isOpen);
      },
      drawer: const BaseDrawer(),
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
            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                                  Get.to(() => const RestaurantsHomeScreen(), binding: RestaurantsHomeBinding());
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
                      return const FailedWidget();
                    }
                }
              },
            ),
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

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    Path path_1 = Path();
    path_1.moveTo(size.width * -0.0002102607, 0);
    path_1.lineTo(size.width * 0.9972666, 0);
    path_1.cubicTo(size.width * 0.9972666, 0, size.width * 1.121531, size.height * 0.8041610, size.width * 0.9972666, size.height * 0.9629127);
    path_1.cubicTo(size.width * 0.8730025, size.height * 1.121664, size.width * 0.7495795, size.height * 0.6350068, size.width * 0.5002103, size.height * 0.6350068);
    path_1.cubicTo(size.width * 0.2508410, size.height * 0.6350068, size.width * 0.1246846, size.height * 1.121664, size.width * -0.0002102607, size.height * 0.9629127);
    path_1.cubicTo(size.width * -0.1251051, size.height * 0.8041610, size.width * -0.0002102607, 0, size.width * -0.0002102607, 0);
    path_1.close();

    return path_1;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
