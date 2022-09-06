import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/view_product.dart';
import 'package:takkeh/controller/restaurants/view_restaurant.dart';
import 'package:takkeh/ui/screens/restaurants/view_restaurant_product.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/products_list_tile.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';

class ViewRestaurantBuilder extends StatelessWidget {
  final int restaurantId;

  const ViewRestaurantBuilder({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GetBuilder<ViewRestaurantCtrl>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: CircularProgressIndicator(
                  color: MyColors.redD4F,
                ),
              ),
            );
            // return const FilterCategoryLoading();
          }

          if (controller.viewRestaurantModel == null) {
            return Center(child: Image.asset(MyImages.failedImage));
          }

          // return Column(
          //   children: List.generate(controller.viewRestaurants.length, (index) {
          //     return ProductsListTile(
          //       imageUrl: 'https://img.freepik.com/free-photo/chicken-wings-barbecue-sweetly-sour-sauce-picnic-summer-menu-tasty-food-top-view-flat-lay_2829-6471.jpg?w=2000',
          //       title: controller.viewRestaurants[index].name!,
          //       price: controller.viewRestaurants[index].price!,
          //       subTitle: controller.viewRestaurants[index].categorise!,
          //       onTap: () {
          //         Get.to(
          //           () => ViewRestaurantProductScreen(
          //             title: controller.viewRestaurants[index].name!,
          //             subTitle: controller.viewRestaurants[index].categorise!,
          //             price: controller.viewRestaurants[index].price!.toDouble(),
          //             choose: controller.viewRestaurants[index].sizes!,
          //             extra: controller.viewRestaurants[index].extras!,
          //             cover: controller.viewRestaurantModel!.data!.cover!,
          //             productId: controller.viewRestaurantModel!.data!.id!,
          //           ),
          //           binding: ViewProductBinding(),
          //         );
          //       },
          //     );
          //   }),
          // );

          //TODO: re-comment later
          return Column(
            children: List.generate(
              controller.viewRestaurants.length,
              (index) {
                controller.itemKeys.add(GlobalKey());
                //TODO: re-comment later
                // if (index == controller.viewRestaurants.length) {
                //   if (controller.loadMore.value) {
                //     return const CustomCircularProgressIndicator(color: MyColors.redD4F);
                //   } else {
                //     return const SizedBox.shrink();
                //   }
                // }
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //153
                          controller.detectPosition(index);
                        },
                        child: Text(
                          "position for $index",
                          key: controller.itemKeys[index],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      ...List.generate(
                        controller.viewRestaurants.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: ProductsListTile(
                              imageUrl: 'https://img.freepik.com/free-photo/chicken-wings-barbecue-sweetly-sour-sauce-picnic-summer-menu-tasty-food-top-view-flat-lay_2829-6471.jpg?w=2000',
                              title: controller.viewRestaurants[index].name!,
                              price: controller.viewRestaurants[index].price!,
                              subTitle: controller.viewRestaurants[index].categorise!,
                              onTap: () {
                                Get.to(
                                  () => ViewRestaurantProductScreen(
                                    title: controller.viewRestaurants[index].name!,
                                    subTitle: controller.viewRestaurants[index].categorise!,
                                    price: controller.viewRestaurants[index].price!.toDouble(),
                                    choose: controller.viewRestaurants[index].sizes!,
                                    extra: controller.viewRestaurants[index].extras!,
                                    cover: controller.viewRestaurantModel!.data!.cover!,
                                    productId: controller.viewRestaurants[index].id!,
                                    restaurantId: restaurantId,
                                  ),
                                  binding: ViewProductBinding(),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
