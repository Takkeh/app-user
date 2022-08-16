import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  Widget getFilter() {
    return Container(
      color: Colors.teal,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (context, index) {
          return ElevatedButton(
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
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
                centerTitle: true,
                title: const Text("hello"),
                // collapsedHeight: 61,
                expandedHeight: 340,
                // floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 120),
                    color: Colors.white,
                    width: double.infinity,
                    height: double.infinity,
                    child: getMostPopular(),
                  ),
                )
                // bottom: PreferredSize(
                //   preferredSize: const Size.fromHeight(0.0),
                //   child: getFilter(),
                // ),
                ),
          ];
        },
        body: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 40,
          itemBuilder: (context, index) {
            return const ListTile(
              leading: Text("hello"),
            );
          },
        ),
      ),
    );
  }
}
