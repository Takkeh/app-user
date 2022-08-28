import 'package:flutter/material.dart';
import 'package:takkeh/controller/home/category.dart';
import 'package:takkeh/model/home/categories_model.dart';
import 'package:takkeh/ui/base/drawer.dart';
import 'package:takkeh/ui/base/home/widgets/home_header.dart';
import 'package:takkeh/ui/base/home/widgets/slider_builder.dart';
import 'package:takkeh/ui/base/home/widgets/takkah_offers_builder.dart';
import 'package:takkeh/ui/base/widgets/home_app_bar.dart';
import 'package:takkeh/ui/base/widgets/home_image_loading.dart';
import 'package:takkeh/ui/base/widgets/special_offers_builder.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/ui/widgets/title_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 2;

  @override
  void initState() {
    CategoriesController.categoriesData = CategoriesController.fetchCategoriesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      onDrawerChanged: (isOpen) {
        //TODO: close nav bar when open
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
            const TitleWidget(
              title: 'Takkeh Offers',
            ),
            const TakkehOffersBuilder(),
            const TitleWidget(
              title: 'Special Offers',
            ),
            const SpecialOffersBuilder(),
          ],
        ),
      ),
    );
  }
}
