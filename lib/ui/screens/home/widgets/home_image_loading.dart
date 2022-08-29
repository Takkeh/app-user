import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_shimmer_loading.dart';

class HomeImageLoading extends StatelessWidget {
  const HomeImageLoading({Key? key}) : super(key: key);

  static Widget getWidget() {
    return const Expanded(
      child: CustomShimmerLoading(
        height: 100,
        radius: 15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
      child: Row(
        children: [
          getWidget(),
          const SizedBox(width: 10),
          getWidget(),
          const SizedBox(width: 10),
          getWidget(),
        ],
      ),
    );
  }
}
