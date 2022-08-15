import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_shimmer_loading.dart';

class HomeImageLoading extends StatelessWidget {
  const HomeImageLoading({Key? key}) : super(key: key);

  static Widget getWidget() {
    return const Expanded(
      child: CustomShimmerLoading(
        radius: 15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 60),
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
