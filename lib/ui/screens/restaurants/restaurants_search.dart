import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:takkeh/binding/restaurants/products.dart';
import 'package:takkeh/controller/restaurants/restaurants_search_ctrl.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/model/restaurants/restaurants_model.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/restaurants/view_restaurant.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/restaurants_app_bar.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/search_field.dart';
import 'package:takkeh/ui/widgets/custom_list_tile.dart';
import 'package:takkeh/ui/widgets/custom_restaurants_loading.dart';
import 'package:takkeh/ui/widgets/restaurant_cpi.dart';
import 'package:takkeh/utils/base/colors.dart';

class RestaurantsSearchScreen extends StatelessWidget {
  const RestaurantsSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RestaurantsAppBar(myContext: context),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 30, right: 50, left: 50),
            decoration: const BoxDecoration(
              color: MyColors.redPrimary,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(150, 60),
              ),
            ),
            child: SearchField(
              autofocus: true,
              readOnly: false,
              hintText: TranslationService.getString('what_to_search_key'),
              onChanged: (value) {
                if (RestaurantsSearchCtrl.find.searchQuery.value != value) {
                  RestaurantsSearchCtrl.find.onSearchChanged(value);
                }
              },
            ),
          ),
          const SizedBox(height: 30),
          GetX<RestaurantsSearchCtrl>(
            builder: (controller) {
              if (controller.searchQuery.isEmpty) {
                return const Text("Search Something");
              }
              return Expanded(
                child: PagedListView<int, RestaurantList>.separated(
                  padding: const EdgeInsets.all(20.0),
                  separatorBuilder: (context, index) => const SizedBox(height: 15),
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<RestaurantList>(
                    noItemsFoundIndicatorBuilder: (context) {
                      return Text("No Result");
                    },
                    firstPageProgressIndicatorBuilder: (context) {
                      return const BaseVerticalListLoading();
                    },
                    newPageProgressIndicatorBuilder: (context) {
                      return const RestaurantCPI();
                    },
                    itemBuilder: (context, data, index) {
                      return CustomListTile(
                        imageUrl: data.logo!,
                        title: data.name!,
                        description: data.description!,
                        reviewIcon: data.reviewIcon!,
                        review: data.review!,
                        time: data.time!,
                        cost: data.cost!,
                        onTap: () {
                          if (UserOrderCtrl.find.orderList.isNotEmpty && UserOrderCtrl.find.restaurantId != data.id!) {
                            // _showMyDialog(context, data: data);
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

          // Obx(
          //   () => RestaurantsSearchCtrl.find.searchQuery.isEmpty
          //       ? const SizedBox.shrink()
          //       : RestaurantsSearchCtrl.find.isLoading.value
          //           ? const RedCircularProgressIndicator()
          //           : ListView.separated(
          //               padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
          //               physics: const NeverScrollableScrollPhysics(),
          //               shrinkWrap: true,
          //               separatorBuilder: (context, index) => const SizedBox(height: 15),
          //               itemCount: RestaurantsSearchCtrl.find.model.value!.data!.length,
          //               itemBuilder: (context, index) {
          //                 final data = RestaurantsSearchCtrl.find.model.value!.data![index];
          //                 return CustomListTile(
          //                   imageUrl: data.logo!,
          //                   title: data.name!,
          //                   description: data.name!,
          //                   onTap: () {
          //                     Get.to(
          //                       () => ViewRestaurantScreen(
          //                         title: data.name!,
          //                         cover: data.cover!,
          //                         restaurantId: data.id!,
          //                         logo: data.logo!,
          //                         time: '',
          //                         cost: '',
          //                         review: '',
          //                         reviewIcon: '',
          //                       ),
          //                       binding: ProductBinding(id: data.id!),
          //                     );
          //                   },
          //                   reviewIcon: '',
          //                   review: '',
          //                   time: '',
          //                   cost: '',
          //                 );
          //               },
          //             ),
          // ),
        ],
      ),
    );
  }
}
