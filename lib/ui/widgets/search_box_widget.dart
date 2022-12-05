import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/restaurant_products_search_binding.dart';
import 'package:takkeh/ui/screens/restaurants/restaurant_products_search_screen.dart';
import 'package:takkeh/utils/base/colors.dart';

class SearchBoxWidget extends StatelessWidget {
  final int restaurantId;

  const SearchBoxWidget({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => RestaurantProductsSearchScreen(restaurantId: restaurantId), binding: RestaurantProductsSearchBinding(restaurantsId: restaurantId));
      },
      child: Container(
        height: 50,
        width: 50,
        margin: const EdgeInsetsDirectional.fromSTEB(20, 5, 5, 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: MyColors.grey4F9.withOpacity(0.70),
          borderRadius: BorderRadius.circular(17),
        ),
        child: const Icon(
          Icons.search,
          color: MyColors.greyEB3,
        ),
      ),
    );
  }
}
