import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_shimmer_loading.dart';
import 'package:takkeh/utils/base/colors.dart';

class ProductsFilterLoading extends StatelessWidget {
  const ProductsFilterLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 15, 8),
        separatorBuilder: (context, index) => const SizedBox(width: 5),
        scrollDirection: Axis.horizontal,
        itemCount: 9,
        itemBuilder: (context, index) {
          return const CustomShimmerLoading(
            radius: 9,
            height: 50,
            width: 80,
            highlightColor: MyColors.redPrimary,
          );
        },
      ),
    );
  }
}
