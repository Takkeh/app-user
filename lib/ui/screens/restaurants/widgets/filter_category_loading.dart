import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_shimmer_loading.dart';

class FilterCategoryLoading extends StatelessWidget {
  const FilterCategoryLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: List.generate(10, (index) {
          return const CustomShimmerLoading(
            margin: EdgeInsets.symmetric(horizontal: 15),
            radius: 17,
            height: 120,
          );
        }),
      ),
    );
  }
}
