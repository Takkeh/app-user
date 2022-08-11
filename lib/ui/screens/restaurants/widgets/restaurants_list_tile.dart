import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/base/colors.dart';

class RestaurantsListTile extends StatelessWidget {
  const RestaurantsListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CustomNetworkImage(
          url: "img/cats/16595352984742.jpg",
          radius: 10,
          width: 70,
          height: 70,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Mcdonald's",
                style: TextStyle(
                  color: MyColors.text,
                  fontSize: 18,
                ),
              ),
              Text(
                "Burger, coffee, donuts",
                style: TextStyle(
                  color: MyColors.greyEB3,
                ),
              ),
              Text(
                "Hello",
                style: TextStyle(
                  color: MyColors.text,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
