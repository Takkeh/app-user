import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/filter_widget.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/restaurants_list_tile.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/search_fieldk_image.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyColors.redD4F,
        leadingWidth: 60,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Card(
            //TODO: change color
            color: MyColors.greyEB3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: const Icon(
              Icons.navigate_before,
              color: Colors.white,
            ),
          ),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(MyIcons.marker),
            const SizedBox(width: 5),
            const Text(
              "Amman, Khalda",
            ),
          ],
        ),
        actions: [
          //TODO: change icon
          SvgPicture.asset(MyIcons.bell),
        ],
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                // margin: const EdgeInsets.only(bottom: 60),
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                height: 200,
                decoration: const BoxDecoration(
                  color: MyColors.redD4F,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(150),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SearchField(
                        hintText: "What do you want to eat ?",
                        controller: TextEditingController(),
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(width: 5),
                    const FilterWidget(),
                  ],
                ),
              ),
              Container(
                height: 50,
                width: 90,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(26),
                  ),
                  color: Colors.white,
                ),
                child: const Text(
                  "Food",
                  style: TextStyle(
                    color: MyColors.primary,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 90,
                height: 80,
                decoration: const BoxDecoration(
                  color: MyColors.primary,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(26),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
                child: CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 0.167,
                    height: 80.0,
                  ),
                  items: [1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          alignment: Alignment.center,
                          width: 30,
                          // decoration: const BoxDecoration(color: Colors.amber),
                          child: SvgPicture.asset(
                            MyIcons.marker,
                            color: Colors.black,
                            height: 60,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemCount: 10,
              itemBuilder: (context, index) {
                return const RestaurantsListTile();
              },
            ),
          ),
        ],
      ),
    );
  }
}
