import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_shimmer_loading.dart';

class WalletLoading extends StatelessWidget {
  const WalletLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(30),
      children: const [
        CustomShimmerLoading(
          radius: 23,
          height: 220,
          padding: EdgeInsets.symmetric(horizontal: 19, vertical: 24),
        ),
        SizedBox(height: 50),
        CustomShimmerLoading(radius: 26,height: 55,),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: CustomShimmerLoading(radius: 26,height: 55,),
        ),
        CustomShimmerLoading(radius: 26,height: 55,),
      ],
    );
  }
}
