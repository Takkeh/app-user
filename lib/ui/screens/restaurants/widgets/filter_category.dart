import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/view_product.dart';
import 'package:takkeh/controller/restaurants/filter_category.dart';
import 'package:takkeh/ui/screens/restaurants/view_produt.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_circular_progress_indicator.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/products_list_tile.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';

class FilterCategoryBuilder extends StatelessWidget {
  const FilterCategoryBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterCategoryCtrl>(
      builder: (controller) {
        if (controller.isLoading.value) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: CircularProgressIndicator(
                  color: MyColors.redD4F,
                ),
              ),
            ),
          );
          // return const FilterCategoryLoading();
        }

        if (controller.filterCategoryModel == null) {
          return Center(child: Image.asset(MyImages.failedImage));
        }

        return SliverToBoxAdapter(
          child: Column(
            children: List.generate(
              controller.filterCategory.length,
              (index) {
                controller.itemKeys.add(GlobalKey());
                if (index + 1 == controller.filterCategory.length) {
                  if (controller.loadMore.value) {
                    return const CustomCircularProgressIndicator(color: MyColors.redD4F);
                  } else {
                    return const SizedBox.shrink();
                  }
                }
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.detect(index);
                        },
                        child: Text(
                          "position for $index",
                          key: controller.itemKeys[index],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      ...List.generate(
                        4,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: ProductsListTile(
                              imageUrl: 'https://img.freepik.com/free-photo/chicken-wings-barbecue-sweetly-sour-sauce-picnic-summer-menu-tasty-food-top-view-flat-lay_2829-6471.jpg?w=2000',
                              title: 'title',
                              price: '12.0',
                              subTitle: 'sub description',
                              onTap: () {
                                Get.to(() => const ViewProductScreen(), binding: ViewProductBinding());
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
