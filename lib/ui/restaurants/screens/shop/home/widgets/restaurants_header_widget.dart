import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:takkeh/controller/restaurants/filter.dart';
import 'package:takkeh/model/restaurants/filter_model.dart';
import 'package:takkeh/ui/restaurants/screens/shop/home/widgets/filter_widget.dart';
import 'package:takkeh/ui/restaurants/screens/shop/home/widgets/search_field.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';

class RestaurantsHeaderWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String title;

  const RestaurantsHeaderWidget({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.title,
  }) : super(key: key);

  @override
  State<RestaurantsHeaderWidget> createState() => _RestaurantsHeaderWidgetState();
}

class _RestaurantsHeaderWidgetState extends State<RestaurantsHeaderWidget> {
  bool isFilterActive = false;

  @override
  void initState() {
    FilterController.filterData = FilterController.fetchCategoriesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 30),
          decoration: const BoxDecoration(
            color: MyColors.redD4F,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(150, 60),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 15),
                child: Row(
                  children: [
                    Expanded(
                      child: SearchField(
                        hintText: "What do you want to eat ?",
                        controller: widget.controller,
                        onChanged: widget.onChanged,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFilterActive = !isFilterActive;
                        });
                      },
                      child: const FilterWidget(),
                    ),
                  ],
                ),
              ),
              FutureBuilder<FilterModel?>(
                future: FilterController.filterData,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const SizedBox(height: 30);
                    case ConnectionState.done:
                    default:
                      if (snapshot.hasData) {
                        return AnimatedContainer(
                          alignment: Alignment.center,
                          duration: const Duration(milliseconds: 250),
                          height: isFilterActive ? 100 : 0,
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
                      } else if (snapshot.hasError) {
                        return const FailedWidget();
                      } else {
                        return const FailedWidget();
                      }
                  }
                },
              ),
            ],
          ),
        ),
        Container(
          height: 50,
          width: 90,
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(26),
            ),
            color: Colors.white,
          ),
          child: FittedBox(
            child: Text(
              widget.title,
              style: const TextStyle(
                color: MyColors.primary,
                fontSize: 20,
              ),
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}
