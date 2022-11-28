import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/controller/restaurants/restaurant_reviews.dart';
import 'package:takkeh/model/restaurants/restaurant_reviews_model.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/restaurant_reviews_loading.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class RestaurantsReviewsBuilder extends StatelessWidget {
  final String imageUrl;
  final int restaurantId;

  const RestaurantsReviewsBuilder({
    Key? key,
    required this.imageUrl,
    required this.restaurantId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RestaurantReviewsModel?>(
      future: RestaurantReviewsCtrl.find.fetchRestaurantReviews(restaurantId: restaurantId),
      builder: (context,snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return const RestaurantReviewsLoading();
          case ConnectionState.done:
          default:
            if(snapshot.hasData){
              final data = snapshot.data!.data!;
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                itemCount: data.reviews!.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      CustomNetworkImage(
                        url: data.reviews![index].userImage!,
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
                                Expanded(
                                  child: Text(
                                    data.reviews![index].content!,
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
                                    Text(
                                      data.reviews![index].reviewString!,
                                      style: const TextStyle(fontSize: 12),
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
            else {
              return FailedWidget();
            }
        }

      }
    );
  }
}
