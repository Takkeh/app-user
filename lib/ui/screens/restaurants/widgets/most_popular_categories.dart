import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/view_product.dart';
import 'package:takkeh/controller/restaurants/most_popular_products.dart';
import 'package:takkeh/model/restaurants/most_popular_model.dart';
import 'package:takkeh/ui/screens/restaurants/view_restaurant_product.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/most_popular_loading.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/most_poular_box.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';

class MostPopularCategoriesBuilder extends StatelessWidget {
  final int restaurantId;

  const MostPopularCategoriesBuilder({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MostPopularProductsModel?>(
      future: MostPopularProductsCtrl.find.initialize,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const MostPopularLoading();
          case ConnectionState.done:
          default:
            if (snapshot.hasData) {
              return Container(
                color: Colors.white,
                height: 165,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
                  itemCount: snapshot.data!.mostPopular!.mostPopularProducts!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.mostPopular!.mostPopularProducts![index];
                    return MostPopularBox(
                      title: data.name!,
                      imageUrl: data.image!,
                      price: data.price!,
                      onTap: () {
                        Get.to(
                          () => ViewRestaurantProductScreen(
                            title: data.name!,
                            description: data.name!,
                            price: data.price!.toDouble(),
                            cover: data.image!,
                            productId: data.id!,
                            restaurantId: restaurantId,
                            groups: data.groups!,
                          ),
                          binding: ViewProductBinding(),
                        );
                      },
                      productId: data.id!,
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
