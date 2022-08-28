import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/restaurants.dart';
import 'package:takkeh/model/restaurants/restaurants_model.dart';
import 'package:takkeh/ui/restaurants/screens/shop/home/widgets/categories_builder.dart';
import 'package:takkeh/ui/restaurants/screens/shop/home/widgets/gradient_colors_box.dart';
import 'package:takkeh/ui/restaurants/screens/shop/home/widgets/restaurants_app_bar.dart';
import 'package:takkeh/ui/restaurants/screens/shop/home/widgets/restaurants_list_tile.dart';
import 'package:takkeh/ui/restaurants/screens/shop/products/products.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';

class RestaurantsHomeScreen extends StatefulWidget {
  const RestaurantsHomeScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantsHomeScreen> createState() => _RestaurantsHomeScreenState();
}

class _RestaurantsHomeScreenState extends State<RestaurantsHomeScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    RestaurantsController.restaurantsData = RestaurantsController.fetchCategoriesData();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const RestaurantsAppBar(),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: const [
              GradientColorsBox(),
              RestaurantCategoriesBuilder(),
            ],
          ),
          const SizedBox(height: 20),
          FutureBuilder<RestaurantsModel?>(
            future: RestaurantsController.restaurantsData,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                default:
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        separatorBuilder: (context, index) => const SizedBox(height: 15),
                        itemCount: snapshot.data!.categorys!.length,
                        itemBuilder: (context, index) {
                          return RestaurantsListTile(
                            imageUrl: snapshot.data!.categorys![index].image!,
                            title: snapshot.data!.categorys![index].name!,
                            description: snapshot.data!.categorys![index].name!,
                            subTitle: snapshot.data!.categorys![index].name!,
                            onTap: () {
                              Get.to(() => const ProductsScreen());
                            },
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const FailedWidget();
                  } else {
                    return const FailedWidget();
                  }
              }
            },
          ),
        ],
      ),
    );
  }
}
