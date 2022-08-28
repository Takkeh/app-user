import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/home/offers.dart';
import 'package:takkeh/model/home/offers_model.dart';
import 'package:takkeh/ui/base/widgets/offers_loading.dart';
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
                        return CustomNetworkImage(
                          url: snapshot.data!.offers![index].image!,
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
    );
  }
}
