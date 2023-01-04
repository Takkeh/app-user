import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/restaurant_categories.dart';
import 'package:takkeh/controller/restaurants/restaurants.dart';
import 'package:takkeh/model/restaurants/restaurant_categories_model.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/restaurants_header_widget.dart';
import 'package:takkeh/ui/widgets/custom_svg_icon.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/constants.dart';

class RestaurantCategoriesBuilder extends StatelessWidget {
  const RestaurantCategoriesBuilder({Key? key}) : super(key: key);

  static int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: [
        GetBuilder<RestaurantCategoriesController>(
          builder: (controller) {
            return RestaurantsHeaderWidget(
              onChanged: (value) {},
              title: controller.categoryTitle.value,
              index: controller.currentIndex.value,
            );
          },
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 90,
              height: 80,
              decoration: kSliderBoxDecoration,
            ),
            FutureBuilder<RestaurantCategoriesModel?>(
              future: RestaurantCategoriesController.find.initialize,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1.5,
                        ),
                      ),
                    );
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasData) {
                      return NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification is ScrollEndNotification) {
                            RestaurantsCtrl.find.pagingController.refresh();
                          }
                          return true;
                        },
                        child: CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 0.25,
                            height: 80.0,
                            onPageChanged: (index, value) {
                              RestaurantCategoriesController.find.onPageChanged(index, snapshot.data!.categorys![index].name!, snapshot.data!.categorys![index].id!);
                            },
                          ),
                          items: snapshot.data!.categorys!.map((element) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GetBuilder<RestaurantCategoriesController>(
                                  builder: (controller) {
                                    if (element.id == 1) {
                                      return CustomSvgIcon(
                                        iconUrl: element.image!,
                                        color: controller.currentIndex.value == 0 ? Colors.white : MyColors.primary,
                                        width: 30,
                                      );
                                    } else {
                                      return CustomSvgIcon(
                                        iconUrl: element.image!,
                                        width: 30,
                                      );
                                    }
                                  },
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
          ],
        ),
      ],
    );
  }
}
