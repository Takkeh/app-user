import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/controller/restaurants/restaurants.dart';
import 'package:takkeh/model/restaurants/restaurants_model.dart';
import 'package:takkeh/ui/restaurants/screens/restaurants/widgets/gradient_colors_box.dart';
import 'package:takkeh/ui/restaurants/screens/restaurants/widgets/restaurants_app_bar.dart';
import 'package:takkeh/ui/restaurants/screens/restaurants/widgets/restaurants_header_widget.dart';
import 'package:takkeh/ui/restaurants/screens/restaurants/widgets/restaurants_list_tile.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/constants.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    RestaurantsController.restaurantsData = RestaurantsController.fetchCategoriesData();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const RestaurantsAppBar(),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              const GradientColorsBox(),
              ListBody(
                children: [
                  RestaurantsHeaderWidget(
                    controller: controller,
                    onChanged: (value) {},
                    title: "Burger",
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 90,
                        height: 80,
                        decoration: kSliderBoxDecoration,
                      ),
                      SizedBox(
                        height: 80,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 0.167,
                            height: 80.0,
                          ),
                          items: [1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  alignment: Alignment.center,
                                  width: 30,
                                  child: SvgPicture.asset(
                                    MyIcons.marker,
                                    color: Colors.black,
                                    height: 60,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          FutureBuilder<RestaurantsModel?>(
            future: RestaurantsController.restaurantsData,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                default:
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        separatorBuilder: (context, index) => const SizedBox(height: 15),
                        itemCount: snapshot.data!.categorys!.length,
                        itemBuilder: (context, index) {
                          return RestaurantsListTile(
                            imageUrl: snapshot.data!.categorys![index].image!,
                            title: snapshot.data!.categorys![index].name!,
                            description: snapshot.data!.categorys![index].name!,
                            subTitle: snapshot.data!.categorys![index].name!,
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
    );
  }
}
