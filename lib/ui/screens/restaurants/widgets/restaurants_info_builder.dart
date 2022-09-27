import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_bubble_image.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/gradient_colors_box.dart';
import 'package:takkeh/ui/widgets/base_switch_slider.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/api_url.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class RestaurantsInfoBuilder extends StatelessWidget {
  const RestaurantsInfoBuilder({Key? key}) : super(key: key);

  static final info = [
    'Khaled',
    'Khaled',
    'Khaled',
    'Khaled',
    'Khaled',
    'Khaled',
    'Khaled',
  ];

  static final icons = [
    MyIcons.camera,
    MyIcons.camera,
    MyIcons.camera,
    MyIcons.camera,
    MyIcons.camera,
    MyIcons.camera,
    MyIcons.camera,
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsetsDirectional.fromSTEB(25, 0, 50, 30),
      itemCount: info.length,
      separatorBuilder: (context, index) => const Divider(indent: 20),
      itemBuilder: (context, index) {
        return ListTile(
          leading: SvgPicture.asset(icons[index], color: MyColors.grey070),
          title: Text(
            info[index],
            style: const TextStyle(fontSize: 16, color: MyColors.grey070),
          ),
          trailing: Text(
            info[index],
            style: const TextStyle(fontSize: 16, color: MyColors.grey070),
          ),
        );
      },
    );
  }
}