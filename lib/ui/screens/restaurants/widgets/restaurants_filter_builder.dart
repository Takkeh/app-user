import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/filter.dart';
import 'package:takkeh/model/restaurants/filter_model.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/filter_bubble.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';

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
              return GetBuilder<RestaurantsFilterController>(
                builder: (controller) {
                  return AnimatedContainer(
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 250),
                    height: controller.isFilterActive.value ? 110 : 0,
                    margin: const EdgeInsets.only(bottom: 30),
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => const SizedBox(width: 5),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.data![index];
                        return FilterBubble(
                          title: data.name!,
                          imageUrl: data.image!,
                          onTap: () {
                            controller.changeSelected(data.id!);
                          },
                          isSelected: controller.selectedTagId.value == data.id!,
                        );
                      },
                    ),
                  );
                },
              );
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
