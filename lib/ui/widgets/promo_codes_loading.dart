import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_shimmer_loading.dart';

class PromoCodesLoading extends StatelessWidget {
  const PromoCodesLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomShimmerLoading(
          radius: 20,
          height: 40,
          width: double.infinity,
          margin: EdgeInsetsDirectional.only(end: 60, start: 30),
        ),
        CustomShimmerLoading(
          radius: 20,
          height: 40,
          margin: EdgeInsetsDirectional.only(end: 30, top: 20, start: 30),
          width: double.infinity,
        ),
      ],
    );
  }
}
