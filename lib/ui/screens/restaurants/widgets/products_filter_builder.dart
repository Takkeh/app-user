import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/products_filter.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_circular_progress_indicator.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/products_filter_loading.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';

class ProductsFilterBuilder extends StatefulWidget {
  const ProductsFilterBuilder({Key? key}) : super(key: key);

  @override
  State<ProductsFilterBuilder> createState() => _ProductsFilterBuilderState();
}

class _ProductsFilterBuilderState extends State<ProductsFilterBuilder> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsFilterCtrl>(
      builder: (controller) {
        if (controller.isLoading.value) {
          return const ProductsFilterLoading();
        }

        if (controller.productsFilterModel == null) {
          return Center(child: Image.asset(MyImages.failedImage));
        }

        return Container(
          color: Colors.white,
          height: 50,
          child: ListView.separated(
            controller: controller.scrollCtrl,
            padding: EdgeInsetsDirectional.fromSTEB(20, 8, controller.allLoaded.value ? 15 : 35, 8),
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            scrollDirection: Axis.horizontal,
            itemCount: controller.filters.length,
            itemBuilder: (context, index) {
              if (index + 1 == controller.filters.length) {
                if (controller.loadMore.value) {
                  return const CustomCircularProgressIndicator(color: MyColors.redD4F);
                } else {
                  return const SizedBox.shrink();
                }
              }
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  backgroundColor: currentIndex == index ? MyColors.redD4F : Colors.transparent,
                  elevation: 0,
                ),
                onPressed: () {
                  setState(() {
                    currentIndex = index;
                  });
                },
                child: Text(
                  controller.filters[index].title!,
                  style: TextStyle(
                    color: currentIndex == index ? Colors.white : MyColors.text,
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
