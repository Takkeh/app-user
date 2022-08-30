import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/view_product.dart';
import 'package:takkeh/ui/screens/restaurants/view_produt.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/most_popular_categories.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/products_fab_button.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/products_filter_builder.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/products_list_tile.dart';
import 'package:takkeh/ui/widgets/back_leading_widget.dart';
import 'package:takkeh/ui/widgets/search_box_widget.dart';
import 'package:takkeh/utils/base/colors.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ScrollController controller;
  late bool isAppBarPinned;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(onScroll);
    isAppBarPinned = true;
  }

  void onScroll() {
    if (controller.position.pixels > 200) {
      if (isAppBarPinned) {
        setState(() => isAppBarPinned = false);
      }
    } else {
      if (!isAppBarPinned) {
        setState(() => isAppBarPinned = true);
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const ProductsFABButton(),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: isAppBarPinned,
            backgroundColor: MyColors.redD4F,
            leadingWidth: 73,
            leading: const BackLeadingWidget(),
            actions: const [
              SearchBoxWidget(),
            ],
            expandedHeight: 470,
            collapsedHeight: kToolbarHeight + 50,
            centerTitle: true,
            title: const Text(
              "Test",
              style: TextStyle(
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
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://img.freepik.com/free-photo/chicken-wings-barbecue-sweetly-sour-sauce-picnic-summer-menu-tasty-food-top-view-flat-lay_2829-6471.jpg?w=2000",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 20,
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: ProductsListTile(
                    imageUrl: 'https://img.freepik.com/free-photo/chicken-wings-barbecue-sweetly-sour-sauce-picnic-summer-menu-tasty-food-top-view-flat-lay_2829-6471.jpg?w=2000',
                    title: 'title',
                    price: '12.0',
                    subTitle: 'sub description',
                    onTap: () {
                      Get.to(() => const ViewProductScreen(), binding: ViewProductBinding());
                    },
                  ),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 80),
          ),
        ],
      ),
    );
  }
}
