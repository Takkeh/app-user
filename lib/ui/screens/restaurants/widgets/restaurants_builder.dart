import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/products.dart';
import 'package:takkeh/controller/restaurants/restaurants.dart';
import 'package:takkeh/ui/screens/restaurants/view_restaurant.dart';
import 'package:takkeh/ui/widgets/custom_list_tile.dart';
import 'package:takkeh/utils/base/images.dart';

class RestaurantsBuilder extends StatelessWidget {
  const RestaurantsBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantsCtrl>(
      builder: (controller) {
        if (controller.isLoading.value) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (controller.restaurantsModel == null) {
          return Center(child: Image.asset(MyImages.failedImage));
        }

        return Expanded(
          child: ListView.separated(
            controller: controller.scrollCtrl,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: controller.allLoaded.value ? 15 : 35),
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemCount: controller.restaurants.length + 1,
            itemBuilder: (context, index) {
              if (index == controller.restaurants.length) {
                if (controller.loadMore.value) {
                  return const Center(
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }
              return CustomListTile(
                imageUrl: controller.restaurants[index].logo!,
                title: controller.restaurants[index].name!,
                description: controller.restaurants[index].name!,
                subTitle: controller.restaurants[index].name!,
                onTap: () {
                  Get.to(
                    () => ViewRestaurantScreen(
                      title: controller.restaurants[index].name!,
                      cover: controller.restaurants[index].cover!,
                      restaurantId: controller.restaurants[index].id!,
                    ),
                    binding: ProductBinding(id: controller.restaurants[index].id!),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
