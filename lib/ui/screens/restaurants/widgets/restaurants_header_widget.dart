import 'package:flutter/material.dart';
import 'package:takkeh/controller/restaurants/filter.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/filter_widget.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/restaurants_filter_builder.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/search_field.dart';
import 'package:takkeh/utils/base/colors.dart';

class RestaurantsHeaderWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String title;
  final int index;

  const RestaurantsHeaderWidget({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.title,
    required this.index,
  }) : super(key: key);

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
                        controller: controller,
                        onChanged: onChanged,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        RestaurantsFilterController.find.toggle();
                      },
                      child: const FilterWidget(),
                    ),
                  ],
                ),
              ),
              const RestaurantsFilterBuilder(),
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
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Text(
              title,
              key: ValueKey<int>(index),
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
