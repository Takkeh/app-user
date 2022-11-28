import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:takkeh/controller/my_orders/my_orders_ctrl.dart';
import 'package:takkeh/model/my_orders/my_orders_model.dart';
import 'package:takkeh/ui/screens/my_orders/widget/my_order_tile.dart';
import 'package:takkeh/ui/screens/my_orders/widget/my_orders_loading.dart';

class MyOrdersBuilder extends StatelessWidget {
  const MyOrdersBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PagedListView<int, OrdersList>.separated(
        padding: const EdgeInsets.all(20),
        pagingController: MyOrdersCtrl.find.pagingController,
        separatorBuilder: (context, index) => const SizedBox(
          height: 15,
        ),
        builderDelegate: PagedChildBuilderDelegate<OrdersList>(
            firstPageProgressIndicatorBuilder: (context) =>
                const MyOrdersLoading(),
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
    );
  }
}
