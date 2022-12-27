import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/view_restaurant.dart';
import 'package:takkeh/model/restaurants/view_restaurant.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/ui/widgets/restaurant_product_categories_loading.dart';
import 'package:takkeh/utils/base/colors.dart';

class ProductsFilterBuilder extends StatelessWidget {
  const ProductsFilterBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ViewRestaurantModel?>(
      future: ViewRestaurantCtrl.find.initialize,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const RestaurantProductCategoriesLoading();
          case ConnectionState.done:
          default:
            if (snapshot.hasData) {
              return Container(
                color: Colors.white,
                height: 50,
                child: ListView.separated(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 20, 8),
                  separatorBuilder: (context, index) => const SizedBox(width: 5),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.categories!.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.categories![index];
                    return GetBuilder<ViewRestaurantCtrl>(
                      builder: (controller) {
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
