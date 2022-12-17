import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/products.dart';
import 'package:takkeh/binding/restaurants/view_product.dart';
import 'package:takkeh/controller/home/offers.dart';
import 'package:takkeh/model/home/offers_model.dart';
import 'package:takkeh/model/restaurants/khaled_model.dart';
import 'package:takkeh/ui/screens/home/widgets/offers_loading.dart';
import 'package:takkeh/ui/screens/restaurants/view_restaurant.dart';
import 'package:takkeh/ui/screens/restaurants/view_restaurant_product.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';

class TakkehOffersBuilder extends StatelessWidget {
  const TakkehOffersBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OffersModel?>(
      future: OffersController.find.initializeOffersFuture,
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
                  items: snapshot.data!.offers!.map((element) {
                    final index = snapshot.data!.offers!.indexOf(element);
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => const ViewRestaurantScreen(
                                restaurantId: 5,
                                title: 'ابو جبارة',
                                cost: 'مجاني',
                                time: '20 - 90 دقيقة',
                                reviewIcon: '4.svg',
                                cover: 'img/restaurants/mcdonald-s.png',
                                logo: 'img/restaurants/16693683296163.jpg',
                                review: 'فاخر',
                                phone: '+96298775785',
                              ),
                              binding: ProductBinding(id: 5),
                            );
                            var list = [
                              {
                                "id": 33,
                                "name": "",
                                "type": "required",
                                "items": [
                                  {"id": 65, "name": "gggg", "price": "10.00"},
                                  {"id": 66, "name": "ggrrr", "price": "20.00"}
                                ]
                              }
                            ];
                            Get.to(
                              () => ViewRestaurantProductScreen(
                                restaurantId: 5,
                                productId: 18,
                                title: 'big mac',
                                description: 'زاكي',
                                price: 22.8,
                                cover: "img/restaurants/mcdonald-s.png",
                                groups: List<ProductGroups>.from(list.map((x) => ProductGroups.fromJson(x))),
                              ),
                              binding: ViewProductBinding(),
                            );
                          },
                          child: CustomNetworkImage(
                            url: snapshot.data!.offers![index].image!,
                            radius: 23,
                            width: Get.width,
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
    );
  }
}
