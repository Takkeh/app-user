import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/ui/widgets/custom_shimmer_loading.dart';

class OffersLoading extends StatelessWidget {
  const OffersLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 370.0,
        viewportFraction: 0.70,
        enlargeCenterPage: true,
      ),
      items: [1, 2, 3].map((element) {
        return Builder(
          builder: (BuildContext context) {
            return CustomShimmerLoading(
              radius: 23,
              width: Get.width,
            );
          },
        );
      }).toList(),
    );
  }
}
