import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/base/colors.dart';

class RestaurantsListTile extends StatelessWidget {
  final String imageUrl, title, subTitle, description;

  const RestaurantsListTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: const Color(0xFFFAF5E6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomNetworkImage(
            url: imageUrl,
            radius: 10,
            width: 80,
            height: 80,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: MyColors.text,
                    fontSize: 18,
                  ),
                ),
                Text(
                  subTitle,
                  style: const TextStyle(
                    color: MyColors.greyEB3,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    color: MyColors.text,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
