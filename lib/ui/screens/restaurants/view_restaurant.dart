import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/most_popular_products.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/most_popular_categories.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/products_fab_button.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/products_filter_builder.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/restaurant_info_bubble.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/view_restaurant_builder.dart';
import 'package:takkeh/ui/widgets/back_leading_widget.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/ui/widgets/search_box_widget.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/custom_clip_path.dart';

class ViewRestaurantScreen extends StatelessWidget {
  final String title, cover, logo, time, cost, review, reviewIcon, phone;
  final int restaurantId;

  const ViewRestaurantScreen({
    Key? key,
    required this.title,
    required this.cover,
    required this.restaurantId,
    required this.logo,
    required this.time,
    required this.cost,
    required this.review,
    required this.reviewIcon,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ProductsFABButton(
        restaurantId: restaurantId,
      ),
      body: GetX<MostPopularProductsCtrl>(
        builder: (controller) {
          return CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: MyColors.redPrimary,
                leadingWidth: 60,
                leading: const BackLeadingWidget(),
                actions: [
                  SearchBoxWidget(restaurantId: restaurantId),
                ],
                expandedHeight: controller.isEmpty.value ? 330 : 533,
                collapsedHeight: kToolbarHeight + 50,
                centerTitle: true,
                title: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            ClipPath(
                              clipper: CustomClipPath(),
                              child: CustomNetworkImage(
                                url: cover,
                                radius: 0,
                                height: 240,
                              ),
                            ),
                            Positioned(
                              bottom: -37,
                              child: RestaurantInfoBubble(
                                title: title,
                                phone: phone,
                                logo: logo,
                                time: time,
                                cost: cost,
                                review: review,
                                cover: cover,
                                restaurantId: restaurantId,
                                reviewIcon: reviewIcon,
                              ),
                            )
                          ],
                        ),
                        // if (controller.isEmpty.value) const SizedBox(height: 20),
                        if (!controller.isEmpty.value)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(28, 70, 0, 10),
                                child: Text(
                                  TranslationService.getString('most_popular_key'),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              MostPopularCategoriesBuilder(restaurantId: restaurantId),
                            ],
                          ),
                      ],
                    ),
                    // child: getMostPopular(),
                  ),
                ),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(0.0),
                  child: ProductsFilterBuilder(),
                ),
              ),
              SliverToBoxAdapter(
                child: ViewRestaurantBuilder(restaurantId: restaurantId),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 80),
              ),
            ],
          );
        },
      ),
    );
  }
}
