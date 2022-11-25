import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_shimmer_loading.dart';

class MostPopularLoading extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final bool shrinkWrap;

  const MostPopularLoading({
    Key? key,
    required this.padding,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 165,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: 12,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              color: const Color(0xFFFAF5E6).withOpacity(0.20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
            child: const Expanded(
              child: CustomShimmerLoading(
                radius: 12,
                width: double.infinity,
                margin: EdgeInsetsDirectional.only(bottom: 3),
              ),
            ),
          );
        },
      ),
    );
  }
}
