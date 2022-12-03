import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/view_product.dart';
import 'package:takkeh/controller/restaurants/restaurant_products_search_ctrl.dart';
import 'package:takkeh/model/restaurants/restaurants_products_search_model.dart';
import 'package:takkeh/ui/screens/restaurants/view_restaurant_product.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/products_list_tile.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/restaurants_app_bar.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/search_bubble.dart';
import 'package:takkeh/ui/widgets/custom_restaurants_loading.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';

class RestaurantProductsSearchScreen extends StatelessWidget {
  final int restaurantId;
  const RestaurantProductsSearchScreen({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RestaurantsAppBar(myContext: context),
      body: GetX<RestaurantProductsSearchCtrl>(
        builder: (controller) {
          return Column(
            children: [
              SearchBubble(
                onChanged: (value) {
                  if (controller.searchQuery.value != value) {
                    controller.onSearchChanged(value);
                  }
                },
              ),
              controller.searchQuery.value.isEmpty
                  ? const Text("Search Something")
                  : FutureBuilder<RestaurantProductsSearchModel?>(
                      future: controller.initialize,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Expanded(
                              child: SingleChildScrollView(
                                child: BaseVerticalListLoading(),
                              ),
                            );
                          case ConnectionState.done:
                          default:
                            if (snapshot.hasData) {
                              if (snapshot.data!.data!.products!.isEmpty) {
                                return const Text("No Result");
                              }
                              return Expanded(
                                child: ListView.separated(
                                    padding: const EdgeInsets.all(20.0),
                                    separatorBuilder: (context, index) => const SizedBox(height: 15),
                                    itemCount: snapshot.data!.data!.products!.length,
                                    itemBuilder: (context, index) {
                                      final data = snapshot.data!.data!.products![index];
                                      return ProductsListTile(
                                        id: data.id!,
                                        imageUrl: data.image!,
                                        title: data.name!,
                                        price: data.price!,
                                        subTitle: data.description!,
                                        onTap: () {
                                          Get.to(
                                            () => ViewRestaurantProductScreen(
                                              title: data.name!,
                                              subTitle: data.description!,
                                              price: data.price!.toDouble(),
                                              cover: data.image!,
                                              productId: data.id!,
                                              restaurantId: restaurantId,
                                              groups: data.groups!,
                                            ),
                                            binding: ViewProductBinding(),
                                          );
                                        },
                                      );
                                    }),
                              );
                            } else {
                              return const FailedWidget();
                            }
                        }
                      },
                    ),
            ],
          );
        },
      ),
    );
  }
}
