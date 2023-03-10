import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/filter.dart';
import 'package:takkeh/utils/base/icons.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 58,
      width: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: GetBuilder<RestaurantsFilterController>(builder: (controller) {
        if (controller.isFilterActive.value) {
          return SvgPicture.asset(MyIcons.arrowUp, height: 20);
        } else {
          return SvgPicture.asset(MyIcons.filter);
        }
      }),
    );
  }
}
