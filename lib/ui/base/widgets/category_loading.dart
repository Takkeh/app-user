import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/ui/widgets/custom_shimmer_loading.dart';

class CategoryLoading extends StatelessWidget {
  const CategoryLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CustomShimmerLoading(
            height: 180,
            radius: 16,
            width: Get.width - 80,
          );
        },
      ),
    );
  }
}
