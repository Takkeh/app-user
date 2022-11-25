import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_shimmer_loading.dart';

class MostPopularLoading extends StatelessWidget {
  const MostPopularLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 165,
      child: ListView.separated(
        padding: const EdgeInsetsDirectional.fromSTEB(28, 0, 28, 0),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const CustomShimmerLoading(
            padding: EdgeInsets.only(bottom: 3),
            radius: 12,
            width: 115,
          );
        },
      ),
    );
  }
}
