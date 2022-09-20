import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/most_popular.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_circular_progress_indicator.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/most_popular_loading.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';

class MostPopularCategoriesBuilder extends StatelessWidget {
  const MostPopularCategoriesBuilder({Key? key}) : super(key: key);

  static Widget getWidget() {
    return Container(
      color: Colors.white,
      height: 165,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 115,
            padding: const EdgeInsets.only(bottom: 3),
            decoration: BoxDecoration(
              color: MyColors.grey9F4,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: NetworkImage("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Spicy Chiken",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const Text(
                  "18.3",
                  style: TextStyle(
                    fontSize: 15,
                    color: MyColors.redPrimary,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MostPopularFilterCtrl>(
      builder: (controller) {
        if (controller.isLoading.value) {
          return const MostPopularLoading();
        }

        if (controller.mostPopularModel == null) {
          return Center(child: Image.asset(MyImages.failedImage));
        }

        return Container(
          color: Colors.white,
          height: 165,
          child: ListView.separated(
            controller: controller.scrollCtrl,
            padding: EdgeInsetsDirectional.fromSTEB(28, 0, controller.allLoaded.value ? 28 : 35, 0),
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: controller.mostPopular.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index + 1 == controller.mostPopular.length) {
                if (controller.loadMore.value) {
                  return const CustomCircularProgressIndicator(color: MyColors.redPrimary);
                } else {
                  return const SizedBox.shrink();
                }
              }
              return Container(
                width: 115,
                padding: const EdgeInsets.only(bottom: 3),
                decoration: BoxDecoration(
                  color: MyColors.grey9F4,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomNetworkImage(
                      width: double.infinity,
                      url: controller.mostPopular[index].thumbnail!,
                      radius: 12,
                      height: 115,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      controller.mostPopular[index].title!,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      controller.mostPopular[index].price!.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: MyColors.redPrimary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
