import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/products.dart';
import 'package:takkeh/controller/restaurants/restaurants_search_ctrl.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/restaurants/view_restaurant.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/restaurants_app_bar.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/search_field.dart';
import 'package:takkeh/ui/widgets/custom_list_tile.dart';
import 'package:takkeh/utils/base/colors.dart';

class RestaurantsSearchScreen extends StatelessWidget {
  const RestaurantsSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RestaurantsAppBar(),
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
                if (RestaurantsSearchCtrl.to.searchQuery.value != value) {
                  RestaurantsSearchCtrl.to.onSearchChanged(value);
                }
              },
            ),
          ),
          Obx(
            () => RestaurantsSearchCtrl.to.searchQuery.isEmpty
                ? const SizedBox.shrink()
                : RestaurantsSearchCtrl.to.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const Divider(
                          indent: 8,
                          endIndent: 8,
                        ),
                        itemCount: RestaurantsSearchCtrl.to.model.value!.data!.length,
                        itemBuilder: (context, index) {
                          final data = RestaurantsSearchCtrl.to.model.value!.data![index];
                          return CustomListTile(
                            imageUrl: data.logo!,
                            title: data.name!,
                            description: data.name!,
                            subTitle: data.name!,
                            onTap: () {
                              Get.to(
                                () => ViewRestaurantScreen(
                                  title: data.name!,
                                  cover: data.cover!,
                                  restaurantId: data.id!,
                                ),
                                binding: ProductBinding(id: data.id!),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
