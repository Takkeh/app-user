import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/home/category.dart';
import 'package:takkeh/model/home/categories_model.dart';
import 'package:takkeh/ui/base/drawer.dart';
import 'package:takkeh/ui/base/widgets/category_loading.dart';
import 'package:takkeh/ui/base/widgets/custom_indicator.dart';
import 'package:takkeh/ui/base/widgets/home_app_bar.dart';
import 'package:takkeh/ui/base/widgets/home_image_loading.dart';
import 'package:takkeh/ui/base/widgets/offers_loading.dart';
import 'package:takkeh/ui/base/widgets/special_offers_loading.dart';
import 'package:takkeh/ui/restaurants/screens/shop/home/home.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/ui/widgets/title_widget.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';

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
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 80),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  height: 180,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: MyColors.primary,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(120),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Hi",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            " Ahmad",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "Hungry? ",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                FutureBuilder<CategoriesModel?>(
                  future: CategoriesController.categoriesData,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const CategoryLoading();
                      case ConnectionState.done:
                      default:
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: 180,
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              separatorBuilder: (context, index) => const SizedBox(width: 15),
                              itemCount: snapshot.data!.categorys!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(() => const RestaurantsHomeScreen());
                                  },
                                  child: CustomNetworkImage(
                                    url: snapshot.data!.categorys![index].image!,
                                    radius: 16,
                                    width: Get.width - 80,
                                  ),
                                );
                              },
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
                      return Container(
                        height: 180,
                        // color: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: CachedNetworkImage(
                                imageUrl: "${ApiUrl.mainUrl}/${snapshot.data!.categorys![0].image!}",
                                placeholder: (context, url) => Image.asset(
                                  MyImages.place,
                                  color: MyColors.primary,
                                ),
                                errorWidget: (context, url, error) => Image.asset(MyImages.place),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CachedNetworkImage(
                                imageUrl: "${ApiUrl.mainUrl}/${snapshot.data!.categorys![0].image!}",
                                placeholder: (context, url) => Image.asset(MyImages.place),
                                errorWidget: (context, url, error) => Image.asset(MyImages.place),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CachedNetworkImage(
                                imageUrl: "${ApiUrl.mainUrl}/${snapshot.data!.categorys![0].image!}",
                                placeholder: (context, url) => Image.asset(MyImages.place),
                                errorWidget: (context, url, error) => Image.asset(MyImages.place),
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
              title: 'Takkah Offers',
            ),
            FutureBuilder<CategoriesModel?>(
              future: CategoriesController.categoriesData,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const OffersLoading();
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 50),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 370.0,
                            viewportFraction: 0.70,
                            enlargeCenterPage: true,
                          ),
                          items: snapshot.data!.categorys!.map((element) {
                            final index = snapshot.data!.categorys!.indexOf(element);
                            return Builder(
                              builder: (BuildContext context) {
                                return CustomNetworkImage(
                                  url: snapshot.data!.categorys![index].image!,
                                  radius: 23,
                                  width: Get.width,
                                );
                              },
                            );
                          }).toList(),
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
              title: 'Special Offers',
            ),
            FutureBuilder<CategoriesModel?>(
              future: CategoriesController.categoriesData,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const SpecialOffersLoading();
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasData) {
                      return ListBody(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                initialPage: 2,
                                height: 120.0,
                                viewportFraction: 0.90,
                                onPageChanged: (index, value) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                                // enlargeCenterPage: true,
                              ),
                              items: snapshot.data!.categorys!.map((element) {
                                final index = snapshot.data!.categorys!.indexOf(element);
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: CustomNetworkImage(
                                        url: snapshot.data!.categorys![index].image!,
                                        radius: 23,
                                        width: Get.width,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < snapshot.data!.categorys!.length; i++)
                                CustomIndicator(
                                  index: currentIndex,
                                  currentWidget: i,
                                ),
                            ],
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const FailedWidget();
                    } else {
                      return const FailedWidget();
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
