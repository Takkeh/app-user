import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/view_restaurant.dart';
import 'package:takkeh/ui/widgets/restaurant_product_categories_loading.dart';
import 'package:takkeh/utils/base/colors.dart';

class ProductsFilterBuilder extends StatelessWidget {
  const ProductsFilterBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewRestaurantCtrl>(
      builder: (controller) {
        if (controller.restaurantProducts.isEmpty) {
          return const RestaurantProductCategoriesLoading();
        }
        return Container(
          color: Colors.white,
          height: 50,
          child: ListView.separated(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 20, 8),
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            scrollDirection: Axis.horizontal,
            itemCount: controller.restaurantProducts.length,
            itemBuilder: (context, index) {
              final data = controller.restaurantProducts[index];
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                  backgroundColor: controller.selectedIndex.value == index ? MyColors.redPrimary : Colors.transparent,
                  elevation: 0,
                ),
                onPressed: () {
                  ViewRestaurantCtrl.find.scrollToItem(index);
                },
                child: Text(
                  data.name!,
                  style: TextStyle(
                    color: controller.selectedIndex.value == index ? Colors.white : MyColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
