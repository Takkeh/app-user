import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/base/colors.dart';

class MostPopularBox extends StatelessWidget {
  final String title, imageUrl;
  final double price;

  const MostPopularBox({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.only(bottom: 3),
      decoration: BoxDecoration(
        color: MyColors.grey9F4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: CustomNetworkImage(
              radius: 12,
              url: imageUrl,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 3),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            price.toString(),
            style: const TextStyle(
              fontSize: 15,
              color: MyColors.redPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
