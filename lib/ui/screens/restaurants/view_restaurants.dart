import 'package:flutter/material.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/most_popular_categories.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/products_fab_button.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/products_filter_builder.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/view_restaurant_builder.dart';
import 'package:takkeh/ui/widgets/back_leading_widget.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/ui/widgets/search_box_widget.dart';
import 'package:takkeh/utils/base/colors.dart';

class ViewRestaurantScreen extends StatelessWidget {
  final String title, cover;

  const ViewRestaurantScreen({
    Key? key,
    required this.title,
    required this.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const ProductsFABButton(),
      body: CustomScrollView(
        // controller: ViewRestaurantCtrl.find.scrollCtrl,
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: MyColors.redD4F,
            leadingWidth: 73,
            leading: const BackLeadingWidget(),
            actions: const [
              SearchBoxWidget(),
            ],
            expandedHeight: 470,
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
                      child: CustomNetworkImage(
                        url: cover,
                        radius: 0,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(28, 20, 0, 10),
                          child: Text(
                            "Most Popular",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        MostPopularCategoriesBuilder(),
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
          const ViewRestaurantBuilder(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 80),
          ),
        ],
      ),
    );
  }
}
