import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/home/home.dart';
import 'package:takkeh/ui/screens/restaurants/restaurant_info.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/most_popular_categories.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/products_fab_button.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/products_filter_builder.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/view_restaurant_builder.dart';
import 'package:takkeh/ui/widgets/back_leading_widget.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/ui/widgets/search_box_widget.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class ViewRestaurantScreen extends StatelessWidget {
  final String title, cover;
  final int restaurantId;

  const ViewRestaurantScreen({
    Key? key,
    required this.title,
    required this.cover,
    required this.restaurantId,
  }) : super(key: key);

  static Widget getWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(MyIcons.clock),
        const SizedBox(height: 5),
        const Text("30 - 40 minutes"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ProductsFABButton(
        restaurantId: restaurantId,
      ),
      body: CustomScrollView(
        // controller: ViewRestaurantCtrl.find.scrollCtrl,
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: MyColors.redPrimary,
            leadingWidth: 73,
            leading: const BackLeadingWidget(),
            actions: const [
              SearchBoxWidget(),
            ],
            expandedHeight: 500,
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
                    Expanded(
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          ClipPath(
                            clipper: CustomClipPath(),
                            child: CustomNetworkImage(
                              url: cover,
                              radius: 0,
                            ),
                          ),
                          Positioned(
                            bottom: -20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    getWidget(),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          () => RestaurantInfoScreen(
                                            title: title,
                                            imageUrl: cover,
                                          ),
                                        );
                                      },
                                      child: Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          const CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                              'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80',
                                            ),
                                          ),
                                          Stack(
                                            alignment: Alignment.topCenter,
                                            children: [
                                              SvgPicture.asset(
                                                MyIcons.halfCircle,
                                                width: 70,
                                              ),
                                              Container(
                                                width: 46,
                                                color: Colors.transparent,
                                                padding: const EdgeInsets.only(top: 2),
                                                child: const FittedBox(
                                                  child: Text(
                                                    "information",
                                                    style: TextStyle(fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    getWidget(),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                getWidget(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(28, 50, 0, 10),
                          child: Text(
                            TranslationService.getString('most_popular_key'),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const MostPopularCategoriesBuilder(),
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
          ViewRestaurantBuilder(restaurantId: restaurantId),
          const SliverToBoxAdapter(
            child: SizedBox(height: 80),
          ),
        ],
      ),
    );
  }
}
