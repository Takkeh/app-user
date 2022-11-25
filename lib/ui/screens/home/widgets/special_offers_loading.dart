import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/ui/widgets/custom_shimmer_loading.dart';

class SpecialOffersLoading extends StatelessWidget {
  const SpecialOffersLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
      child: CarouselSlider(
        options: CarouselOptions(
          initialPage: 2,
          height: 120.0,
          viewportFraction: 0.90,
          // enlargeCenterPage: true,
        ),
        items: [1, 2, 3].map((element) {
          return Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CustomShimmerLoading(
                  radius: 23,
                  width: Get.width,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
