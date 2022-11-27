import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_shimmer_loading.dart';

class FaqLoading extends StatelessWidget {
  const FaqLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      padding: const EdgeInsets.all(30),
      itemCount: 5,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(17),
          child: const CustomShimmerLoading(
            radius: 17,
            height: 60,
            width: double.infinity,
          ),
        );
      },
    );
  }
}
