import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:takkeh/controller/my_orders/my_orders_ctrl.dart';
import 'package:takkeh/model/my_orders/my_orders_model.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/my_orders/widget/my_order_tile.dart';
import 'package:takkeh/ui/widgets/custom_restaurants_loading.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    Get.put(MyOrdersCtrl());
    super.initState();
  }

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
          body: PagedListView<int, OrdersList>.separated(
            padding: const EdgeInsets.all(20),
            pagingController: MyOrdersCtrl.find.pagingController,
            separatorBuilder: (context, index) => const SizedBox(
              height: 15,
            ),
            builderDelegate: PagedChildBuilderDelegate<OrdersList>(
                firstPageProgressIndicatorBuilder: (context) => const BaseVerticalListLoading(),
                itemBuilder: (context, data, index) {
                  return MyOrderTile(
                    onTap: () {},
                    id: '${data.orderNumber!}',
                    name: data.restaurantName!,
                    date: data.createdAt!,
                    logo: data.restaurantLogo!,
                  );
                }),
          ),
        ),
      ],
    );
  }
}
