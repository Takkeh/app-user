import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:takkeh/controller/restaurants/restaurant_reviews.dart';
import 'package:takkeh/controller/restaurants/restaurants.dart';
import 'package:takkeh/model/restaurants/restaurant_info_model.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/restaurant_reviews_loading.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/ui/widgets/no_items_found_widget.dart';
import 'package:takkeh/ui/widgets/restaurant_cpi.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class RestaurantsReviewsBuilder extends StatefulWidget {
  final String imageUrl;
  final int restaurantId;

  const RestaurantsReviewsBuilder({
    Key? key,
    required this.imageUrl,
    required this.restaurantId,
  }) : super(key: key);

  @override
  State<RestaurantsReviewsBuilder> createState() => _RestaurantsReviewsBuilderState();
}

class _RestaurantsReviewsBuilderState extends State<RestaurantsReviewsBuilder> {
  @override
  void initState() {
    Get.lazyPut(() => RestaurantReviewsCtrl());
    RestaurantReviewsCtrl.find.restaurantId = widget.restaurantId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Review>.separated(
      padding: const EdgeInsets.all(20),
      pagingController: RestaurantReviewsCtrl.find.pagingController,
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      builderDelegate: PagedChildBuilderDelegate<Review>(
          firstPageProgressIndicatorBuilder: (context) => const RestaurantReviewsLoading(),
          newPageProgressIndicatorBuilder: (context) {
            // if () {
            //   return const SizedBox.shrink();
            // } else {
            //   print("alskfjasklfj");
            //   return const RestaurantCPI();
            // }
            return const RestaurantCPI();
          },
          noItemsFoundIndicatorBuilder: (context) {
            return NoItemsFoundWidget(text: TranslationService.getString("no_reviews_found_key"));
          },
          itemBuilder: (context, data, index) {
            return Row(
              children: [
                CustomNetworkImage(
                  url: data.userImage!,
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
                              data.content!,
                            ),
                          ),
                          const VerticalDivider(indent: 0, endIndent: 0),
                          const SizedBox(width: 20),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                MyIcons.getReviewIcon(data.reviewIcon!),
                                height: 40,
                              ),
                              Text(
                                data.reviewString!,
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
          }),
    );
  }
}
