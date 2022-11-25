import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_shimmer_loading.dart';

class RestaurantProductCategoriesLoading extends StatelessWidget {
  const RestaurantProductCategoriesLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 5),
        padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 20, 8),
        scrollDirection: Axis.horizontal,
        itemCount: 12,
        itemBuilder: (context, index) {
          return const CustomShimmerLoading(
            radius: 9,
            height: 40.0,
            width: 100.0,
          );
        },
      ),
    );
  }
}
