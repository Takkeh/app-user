import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/ui/widgets/custom_shimmer_loading.dart';

class SpecialOffersLoading extends StatelessWidget {
  const SpecialOffersLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 50),
      child: CarouselSlider(
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
      ),
    );
  }
}
