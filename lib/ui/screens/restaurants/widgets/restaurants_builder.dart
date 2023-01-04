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
import 'package:takkeh/ui/widgets/no_items_found_widget.dart';
import 'package:takkeh/ui/widgets/restaurant_cpi.dart';
import 'package:takkeh/ui/widgets/restaurant_list_tile.dart';

class RestaurantsBuilder extends StatelessWidget {
  const RestaurantsBuilder({Key? key}) : super(key: key);

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
          noItemsFoundIndicatorBuilder: (context) {
            return NoItemsFoundWidget(text: TranslationService.getString("no_restaurants_found_key"));
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
