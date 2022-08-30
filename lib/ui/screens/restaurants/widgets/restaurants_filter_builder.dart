import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/filter.dart';
import 'package:takkeh/model/restaurants/filter_model.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';

class RestaurantsFilterBuilder extends StatelessWidget {
  const RestaurantsFilterBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FilterModel?>(
      future: RestaurantsFilterController.find.initialize,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const SizedBox(height: 30);
          case ConnectionState.done:
          default:
            if (snapshot.hasData) {
              return GetBuilder<RestaurantsFilterController>(builder: (controller) {
                return AnimatedContainer(
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 250),
                  height: controller.isFilterActive.value ? 100 : 0,
                  margin: const EdgeInsets.only(bottom: 30),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(width: 5),
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.categorys!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        width: 80,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: MyColors.redB3A,
                          borderRadius: BorderRadius.circular(27),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: CachedNetworkImage(
                                imageUrl: "${ApiUrl.mainUrl}/${snapshot.data!.categorys![index].image!}",
                                placeholder: (context, url) => Image.asset(MyImages.placeHolder),
                                errorWidget: (context, url, error) => Image.asset(MyImages.placeHolder),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Flexible(
                              child: FittedBox(
                                child: Text(
                                  snapshot.data!.categorys![index].name!,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              });
            } else if (snapshot.hasError) {
              return const FailedWidget();
            } else {
              return const FailedWidget();
            }
        }
      },
    );
  }
}
