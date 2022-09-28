import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:takkeh/controller/home/category.dart';
import 'package:takkeh/controller/nav_bar_ctrl.dart';
import 'package:takkeh/model/home/categories_model.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/base/drawer.dart';
import 'package:takkeh/ui/screens/home/widgets/home_app_bar.dart';
import 'package:takkeh/ui/screens/home/widgets/home_header.dart';
import 'package:takkeh/ui/screens/home/widgets/home_image_loading.dart';
import 'package:takkeh/ui/screens/home/widgets/slider_builder.dart';
import 'package:takkeh/ui/screens/home/widgets/special_offers_builder.dart';
import 'package:takkeh/ui/screens/home/widgets/takkah_offers_builder.dart';
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
    CategoriesController.categoriesData = CategoriesController.fetchCategoriesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var myDoc = await FirebaseFirestore.instance.collection('khaled').get();
          print("test:: ${myDoc.docs[0].data()}");
        },
      ),
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
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
            //   child: Row(
            //     children: images.map((element) {
            //       final index = images.indexOf(element);
            //       return Expanded(
            //         child: GestureDetector(
            //           onTap: () {
            //             switch (index) {
            //               case 0:
            //                 {
            //                   Get.to(() => const RestaurantsHomeScreen(), binding: RestaurantsHomeBinding());
            //                 }
            //                 break;
            //               case 1:
            //                 {}
            //                 break;
            //               case 2:
            //                 {}
            //                 break;
            //             }
            //           },
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 5.0),
            //             child: Image.asset(
            //               element,
            //             ),
            //           ),
            //         ),
            //       );
            //     }).toList(),
            //   ),
            // ),
            FutureBuilder<CategoriesModel?>(
              future: CategoriesController.categoriesData,
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
                          children: const [
                            Expanded(
                              child: CustomNetworkImage(
                                height: 100,
                                url: 'img/cats/16616923551881.svg',
                                radius: 15,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CustomNetworkImage(
                                height: 100,
                                url: 'img/cats/16616923551881.svg',
                                radius: 15,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CustomNetworkImage(
                                height: 100,
                                url: 'img/cats/16616923551881.svg',
                                radius: 15,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const FailedWidget();
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
