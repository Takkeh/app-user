import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/controller/restaurants/shop/restaurant_categories.dart';
import 'package:takkeh/model/restaurants/shop/restaurant_categories_model.dart';
import 'package:takkeh/ui/restaurants/screens/shop/home/widgets/restaurants_header_widget.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/constants.dart';

class RestaurantCategoriesBuilder extends StatefulWidget {
  const RestaurantCategoriesBuilder({Key? key}) : super(key: key);

  @override
  State<RestaurantCategoriesBuilder> createState() => _RestaurantCategoriesBuilderState();
}

class _RestaurantCategoriesBuilderState extends State<RestaurantCategoriesBuilder> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RestaurantCategoriesModel?>(
      future: RestaurantCategoriesController.find.initialize,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.done:
          default:
            if (snapshot.hasData) {
              return ListBody(
                children: [
                  RestaurantsHeaderWidget(
                    controller: TextEditingController(),
                    onChanged: (value) {},
                    title: snapshot.data!.categorys![currentIndex].name!,
                    index: currentIndex,
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
                            onPageChanged: (index, value) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                          ),
                          items: snapshot.data!.categorys!.map((element) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  alignment: Alignment.center,
                                  width: 30,
                                  child: SvgPicture.network(
                                    '${ApiUrl.mainUrl}/${element.image!}',
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
              );
            } else if (snapshot.hasError) {
              return const FailedWidget();
            } else {
              return const FailedWidget();
            }
        }
      },
    );
  }
}
