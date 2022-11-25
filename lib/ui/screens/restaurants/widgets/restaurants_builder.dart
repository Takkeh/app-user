import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/products.dart';
import 'package:takkeh/controller/restaurants/restaurants.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/model/restaurants/restaurants_model.dart';
import 'package:takkeh/ui/screens/restaurants/view_restaurant.dart';
import 'package:takkeh/ui/widgets/custom_list_tile.dart';
import 'package:takkeh/ui/widgets/custom_vertical_list_loading.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';

class RestaurantsBuilder extends StatelessWidget {
  const RestaurantsBuilder({Key? key}) : super(key: key);

  Future<void> _showMyDialog(
    BuildContext context, {
    required Datum data,
  }) async {
    //TODO: translate
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Start a new basket?'.tr),
          content: Text('A new order will clear your basket.'.tr),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'.tr),
              onPressed: () {
                Get.back();
              },
            ),
            ElevatedButton(
              child: Text('Start'.tr),
              onPressed: () {
                Get.delete<UserOrderCtrl>(force: true);
                Get.put(UserOrderCtrl(), permanent: true);
                UserOrderCtrl.find.restaurantId = data.id!;
                Get.back();
                Get.to(
                  () => ViewRestaurantScreen(
                    title: data.name!,
                    cover: data.cover!,
                    restaurantId: data.id!,
                    logo: data.logo!,
                    time: data.time!,
                    cost: data.cost!,
                    review: data.review!,
                  ),
                  binding: ProductBinding(id: data.id!),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RestaurantsModel?>(
      future: RestaurantsCtrl.find.initialize,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Expanded(
              child: CustomVerticalListLoading(
                padding: EdgeInsets.all(20.0),
              ),
            );
          case ConnectionState.done:
          default:
            if (snapshot.hasData) {
              return Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20.0),
                  separatorBuilder: (context, index) => const SizedBox(height: 15),
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.data![index];
                    return CustomListTile(
                      imageUrl: data.logo!,
                      title: data.name!,
                      description: data.name!,
                      reviewIcon: data.reviewIcon!,
                      review: data.review!,
                      time: data.time!,
                      cost: data.cost!,
                      onTap: () {
                        if (UserOrderCtrl.find.orderList.isNotEmpty && UserOrderCtrl.find.restaurantId != data.id!) {
                          _showMyDialog(context, data: data);
                        } else {
                          UserOrderCtrl.find.restaurantId = data.id!;
                          Get.to(
                            () => ViewRestaurantScreen(
                              title: data.name!,
                              cover: data.cover!,
                              restaurantId: data.id!,
                              logo: data.logo!,
                              time: data.time!,
                              cost: data.cost!,
                              review: data.review!,
                            ),
                            binding: ProductBinding(id: data.id!),
                          );
                        }
                      },
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
