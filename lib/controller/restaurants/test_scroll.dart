import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/products_filter.dart';
import 'package:takkeh/ui/widgets/back_leading_widget.dart';
import 'package:takkeh/utils/base/colors.dart';

class ScrollTest extends StatefulWidget {
  const ScrollTest({Key? key}) : super(key: key);

  @override
  State<ScrollTest> createState() => _ScrollTestState();
}

class _ScrollTestState extends State<ScrollTest> {
  final _key = GlobalKey();
  late ScrollController scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.lazyPut(() => ProductsFilterCtrl());
    // Get.lazyPut(() => MostPopularProductsCtrl());
    scrollController = ScrollController();
    scrollController.addListener(() {
      print("aosifhasfio");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              backgroundColor: MyColors.redPrimary,
              leadingWidth: 73,
              leading: const BackLeadingWidget(),
              actions: const [
                // SearchBoxWidget(restaurantId: null,),
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
                          // MostPopularCategoriesBuilder(),
                        ],
                      ),
                    ],
                  ),
                  // child: getMostPopular(),
                ),
              ),
              // bottom: PreferredSize(
              //   preferredSize: const Size.fromHeight(0.0),
              //   child: ProductsFilterBuilder(myFunction: scrollToItem),
              // ),
            ),
          ];
        },
        body: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemCount: 40,
          itemBuilder: (context, index) {
            return GestureDetector(
              key: index == 2 ? _key : null,
              onTap: index == 2
                  ? () {
                      final RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
                      final position = renderBox.localToGlobal(Offset.zero);
                      print("position:: $position");
                      if (position.dy >= 250) {
                        print("asilfhasfih");
                      }
                    }
                  : null,
              child: Container(
                height: 100,
                color: index == 2 ? Colors.orange : Colors.red,
                alignment: Alignment.center,
                child: const Text("hello"),
              ),
            );
          },
        ),
      ),
    );
  }
}
