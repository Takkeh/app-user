import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_shimmer_loading.dart';
import 'package:takkeh/utils/base/colors.dart';

class FilterCategoryLoading extends StatelessWidget {
  const FilterCategoryLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: CustomShimmerLoading(
        radius: 17,
        height: 150,
        highlightColor: MyColors.redD4F,
      ),
    );
  }
}
