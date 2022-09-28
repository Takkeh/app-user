import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class RestaurantsReviewsBuilder extends StatelessWidget {
  final String imageUrl;

  const RestaurantsReviewsBuilder({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Row(
          children: [
            CustomNetworkImage(
              url: imageUrl,
              radius: 100,
              height: 70,
              width: 70,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17.0),
                  color: MyColors.whiteDFE,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "اشي خرافي بكل معنى الكلمة ممتاز جداً وانصح الكل فيه زاكي ومرتب والتغليف تبعه ممتاز شكراً الكم.",
                        ),
                      ),
                      const VerticalDivider(indent: 0, endIndent: 0),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            MyIcons.emojiLove,
                            height: 40,
                          ),
                          const Text(
                            "مرتب",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
