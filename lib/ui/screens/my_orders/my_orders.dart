import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/my_orders/widget/my_orders_builder.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';


class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          color: MyColors.blue6FA,
          height: Get.height,
          child: Image.asset(
            MyImages.handUpTransparent,
            height: 300,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: TransparentAppBar(title: TranslationService.getString('my_orders_key')),
          body: Column(
            children: const [
              MyOrdersBuilder(),
            ],
          ),

        ),
      ],
    );
  }
}
