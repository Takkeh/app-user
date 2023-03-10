import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/products.dart';
import 'package:takkeh/binding/restaurants/view_product.dart';
import 'package:takkeh/controller/home/offers.dart';
import 'package:takkeh/model/home/offers_model.dart';
import 'package:takkeh/services/offers_route_service.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/home/widgets/offers_loading.dart';
import 'package:takkeh/ui/screens/restaurants/view_restaurant.dart';
import 'package:takkeh/ui/screens/restaurants/view_restaurant_product.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';

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
                            OffersRouteService().toggleRoute(element);
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
