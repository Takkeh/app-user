import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:takkeh/binding/restaurants/products.dart';
import 'package:takkeh/controller/restaurants/restaurants_search_ctrl.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/model/restaurants/restaurants_model.dart';
import 'package:takkeh/ui/screens/restaurants/view_restaurant.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/no_result_search_widget.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/restaurants_app_bar.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/search_bubble.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/search_something_widget.dart';
import 'package:takkeh/ui/widgets/components/new_basket_dialog.dart';
import 'package:takkeh/ui/widgets/custom_restaurants_loading.dart';
import 'package:takkeh/ui/widgets/restaurant_cpi.dart';
import 'package:takkeh/ui/widgets/restaurant_list_tile.dart';

//TODO: search and pagination
class RestaurantsSearchScreen extends StatelessWidget {
  const RestaurantsSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RestaurantsAppBar(),
      body: Column(
        children: [
          SearchBubble(
            onChanged: (value) {
              if (RestaurantsSearchCtrl.find.searchQuery.value != value) {
                RestaurantsSearchCtrl.find.onSearchChanged(value);
              }
            },
          ),
          GetX<RestaurantsSearchCtrl>(
            builder: (controller) {
              if (controller.searchQuery.isEmpty) {
                return const SearchSomethingWidget();
              }
              return Expanded(
                child: PagedListView<int, RestaurantList>.separated(
                  padding: const EdgeInsets.all(20.0),
                  separatorBuilder: (context, index) => const SizedBox(height: 15),
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<RestaurantList>(
                    noItemsFoundIndicatorBuilder: (context) {
                      return const NoResultSearchWidget();
                    },
                    firstPageProgressIndicatorBuilder: (context) {
                      return const BaseVerticalListLoading();
                    },
                    newPageProgressIndicatorBuilder: (context) {
                      return const RestaurantCPI();
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
            },
          ),
        ],
      ),
    );
  }
}
