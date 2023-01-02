import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:takkeh/binding/restaurants/products.dart';
import 'package:takkeh/controller/restaurants/restaurants.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/model/restaurants/restaurants_model.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/restaurants/view_restaurant.dart';
import 'package:takkeh/ui/widgets/components/new_basket_dialog.dart';
import 'package:takkeh/ui/widgets/custom_restaurants_loading.dart';
import 'package:takkeh/ui/widgets/restaurant_cpi.dart';
import 'package:takkeh/ui/widgets/restaurant_list_tile.dart';

class RestaurantsBuilder extends StatelessWidget {
  const RestaurantsBuilder({Key? key}) : super(key: key);

  Future<void> _showMyDialog(
    BuildContext context, {
    required RestaurantList data,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(TranslationService.getString('start_new_basket_key')),
          content: Text(TranslationService.getString('new_order_will_clear_basket_key')),
          actions: <Widget>[
            TextButton(
              child: Text(TranslationService.getString('cancel_key')),
              onPressed: () {
                Get.back();
              },
            ),
            ElevatedButton(
              child: Text(TranslationService.getString('start_key')),
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
                    reviewIcon: data.reviewIcon!,
                    phone: '+96298775785',
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
    return Expanded(
      child: PagedListView<int, RestaurantList>.separated(
        padding: const EdgeInsets.all(20.0),
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        pagingController: RestaurantsCtrl.find.pagingController,
        builderDelegate: PagedChildBuilderDelegate<RestaurantList>(
          firstPageProgressIndicatorBuilder: (context) {
            return const BaseVerticalListLoading();
          },
          newPageProgressIndicatorBuilder: (context) {
            if (RestaurantsCtrl.find.pagingController.itemList!.length < 6) {
              return const SizedBox.shrink();
            } else {
              return const RestaurantCPI();
            }
          },
          itemBuilder: (context, data, index) {
            return RestaurantListTile(
              imageUrl: data.logo!,
              title: data.name!,
              description: data.description!,
              reviewIcon: data.reviewIcon!,
              review: data.review!,
              time: data.time!,
              cost: data.cost!,
              isBusy: data.isBusy!,
              onTap: () {
                if (UserOrderCtrl.find.orderList.isNotEmpty && UserOrderCtrl.find.restaurantId != data.id!) {
                  NewBasketDialog().show(data: data);
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
                      reviewIcon: data.reviewIcon!,
                      //TODO: missing api data
                      phone: '+96298775785',
                    ),
                    binding: ProductBinding(id: data.id!),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
