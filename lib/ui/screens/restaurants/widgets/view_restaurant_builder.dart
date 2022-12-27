import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/view_product.dart';
import 'package:takkeh/controller/restaurants/view_restaurant.dart';
import 'package:takkeh/model/restaurants/view_restaurant.dart';
import 'package:takkeh/ui/screens/restaurants/view_restaurant_product.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/products_list_tile.dart';
import 'package:takkeh/ui/widgets/custom_vertical_list_loading.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/utils/base/colors.dart';

class ViewRestaurantBuilder extends StatelessWidget {
  final int restaurantId;

  const ViewRestaurantBuilder({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ViewRestaurantModel?>(
      future: ViewRestaurantCtrl.find.initialize,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CustomVerticalListLoading(
              shrinkWrap: true,
              padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
            );
          case ConnectionState.done:
          default:
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  snapshot.data!.categories!.length,
                  (number) {
                    final info = snapshot.data!.categories![number];
                    ViewRestaurantCtrl.find.itemKeys.add(GlobalKey());
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            info.name!,
                            key: ViewRestaurantCtrl.find.itemKeys[number],
                            style: const TextStyle(
                              fontSize: 20,
                              color: MyColors.redPrimary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          ...List.generate(
                            snapshot.data!.categories![number].products!.length,
                            (index) {
                              final data = snapshot.data!.categories![number].products![index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6.0),
                                child: ProductsListTile(
                                  id: data.id!,
                                  imageUrl: data.image!,
                                  title: data.name!,
                                  price: data.price!,
                                  description: data.description!,
                                  //TODO: missing api data
                                  isAvailable: index == 0 ? 0 : 1,
                                  onTap: () {
                                    Get.to(
                                      () => ViewRestaurantProductScreen(
                                        title: data.name!,
                                        description: data.description!,
                                        price: data.price!.toDouble(),
                                        cover: data.image!,
                                        productId: data.id!,
                                        restaurantId: restaurantId,
                                        groups: data.groups!,
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
            } else {
              return const FailedWidget();
            }
        }
      },
    );
  }
}
