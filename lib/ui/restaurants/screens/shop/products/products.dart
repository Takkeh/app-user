import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/ui/restaurants/screens/shop/view_produt.dart';
import 'package:takkeh/ui/widgets/back_leading_widget.dart';
import 'package:takkeh/ui/widgets/search_box_widget.dart';
import 'package:takkeh/utils/base/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  Widget getFilter() {
    return Container(
      color: Colors.white,
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        separatorBuilder: (context, index) => const SizedBox(width: 5),
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (context, index) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green),
            onPressed: () {},
            child: Text("Menu $index"),
          );
        },
      ),
    );
  }

  Widget getMostPopular() {
    return SizedBox(
      height: 165,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 115,
            padding: const EdgeInsets.only(bottom: 3),
            decoration: BoxDecoration(
              color: MyColors.grey9F4,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: NetworkImage("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Spicy Chiken",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const Text(
                  "18.3",
                  style: TextStyle(
                    fontSize: 15,
                    color: MyColors.redD4F,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            // stretch: false,
            // stretchTriggerOffset: 10,
            // scrolledUnderElevation: 300.0,
            // surfaceTintColor: Colors.teal,
            // foregroundColor: Colors.red,
            // snap: false,

            pinned: true,
            floating: true,
            backgroundColor: Colors.white,
            leadingWidth: 73,
            leading: const BackLeadingWidget(),
            actions: const [
              SearchBoxWidget(),
            ],
            expandedHeight: 500,
            collapsedHeight: kToolbarHeight + 50,
            centerTitle: true,
            // toolbarHeight: 100,
            title: const Text(
              "Test",
              style: TextStyle(color: MyColors.text),
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                color: Colors.white,
                padding: const EdgeInsets.only(bottom: 80),
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
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(28, 20, 0, 10),
                          child: Text(
                            "Most Popular",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        getMostPopular(),
                      ],
                    ),
                  ],
                ),
                // child: getMostPopular(),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: getFilter(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 20,
              (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => const ViewProductScreen());
                  },
                  child: Card(
                    margin: const EdgeInsets.all(15),
                    child: Container(
                      color: Colors.blue[100 * (index % 9 + 1)],
                      height: 80,
                      alignment: Alignment.center,
                      child: Text(
                        "Item $index",
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
