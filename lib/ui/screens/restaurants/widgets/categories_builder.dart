import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/restaurant_categories.dart';
import 'package:takkeh/model/restaurants/restaurant_categories_model.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/restaurants_header_widget.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/constants.dart';

class RestaurantCategoriesBuilder extends StatelessWidget {
  const RestaurantCategoriesBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: [
        GetBuilder<RestaurantCategoriesController>(builder: (controller) {
          return RestaurantsHeaderWidget(
            controller: TextEditingController(),
            onChanged: (value) {},
            title: controller.categoryTitle.value,
            index: controller.currentIndex.value,
          );
        }),
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
                      return SizedBox(
                        height: 80,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            viewportFraction: 0.167,
                            height: 80.0,
                            onPageChanged: (index, value) {
                              RestaurantCategoriesController.find.onPageChanged(index, snapshot.data!.categorys![index].name!);
                            },
                          ),
                          items: snapshot.data!.categorys!.map((element) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  alignment: Alignment.center,
                                  width: 30,
                                  child: element.id == 1
                                      ? GetBuilder<RestaurantCategoriesController>(builder: (controller) {
                                          return SvgPicture.network(
                                            '${ApiUrl.mainUrl}/${element.image!}',
                                            height: 80,
                                            color: controller.currentIndex.value == 0 ? Colors.white : MyColors.primary,
                                          );
                                        })
                                      : SvgPicture.network(
                                          '${ApiUrl.mainUrl}/${element.image!}',
                                          height: 80,
                                        ),
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
