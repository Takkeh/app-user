import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/home/special_offers.dart';
import 'package:takkeh/model/home/special_offers_model.dart';
import 'package:takkeh/ui/base/widgets/custom_indicator.dart';
import 'package:takkeh/ui/base/widgets/special_offers_loading.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';

class SpecialOffersBuilder extends StatefulWidget {
  const SpecialOffersBuilder({Key? key}) : super(key: key);

  @override
  State<SpecialOffersBuilder> createState() => _SpecialOffersBuilderState();
}

class _SpecialOffersBuilderState extends State<SpecialOffersBuilder> {
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SpecialOffersModel?>(
      future: SpecialOffersController.find.initializeSpecialOffersFuture,
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
                      items: snapshot.data!.specials!.map((element) {
                        final index = snapshot.data!.specials!.indexOf(element);
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CustomNetworkImage(
                                url: snapshot.data!.specials![index].image!,
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
                      for (int i = 0; i < snapshot.data!.specials!.length; i++)
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
    );
  }
}
