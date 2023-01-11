import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/restaurant_info.dart';
import 'package:takkeh/model/restaurants/restaurant_info_model.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/ui/widgets/restaurant_cpi.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class RestaurantsInfoBuilder extends StatefulWidget {
  final int restaurantId;
  const RestaurantsInfoBuilder({Key? key, required this.restaurantId}) : super(key: key);

  @override
  State<RestaurantsInfoBuilder> createState() => _RestaurantsInfoBuilderState();
}

class _RestaurantsInfoBuilderState extends State<RestaurantsInfoBuilder> {
  @override
  void initState() {
    Get.lazyPut(() => RestaurantInfoCtrl());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RestaurantInfoModel?>(
        future: RestaurantInfoCtrl.find.fetchInfoData(restaurantId: widget.restaurantId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const RestaurantCPI();
            case ConnectionState.done:
            default:
              if (snapshot.hasData) {
                final data = snapshot.data!.data!;
                return SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.fromSTEB(25, 0, 50, 30),
                  child: Column(
                    children: [
                      ListTile(
                        leading: SvgPicture.asset(MyIcons.mapMarker, color: MyColors.grey070),
                        title: Text(
                          TranslationService.getString('Restaurant_address_key'),
                          style: const TextStyle(fontSize: 16, color: MyColors.grey070),
                        ),
                        trailing: Text(
                          data.address!,
                          style: const TextStyle(fontSize: 16, color: MyColors.grey070),
                        ),
                      ),
                      const Divider(
                        height: 0,
                        indent: 30,
                        thickness: 0.9,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(MyIcons.clockThree, color: MyColors.grey070),
                        title: Text(
                          TranslationService.getString('work_time_key'),
                          style: const TextStyle(fontSize: 16, color: MyColors.grey070),
                        ),
                        trailing: Text(
                          data.workTime!,
                          style: const TextStyle(fontSize: 16, color: MyColors.grey070),
                        ),
                      ),
                      const Divider(
                        height: 0,
                        indent: 30,
                        thickness: 0.9,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(MyIcons.biking, color: MyColors.grey070),
                        title: Text(
                          TranslationService.getString('delivery_time_key'),
                          style: const TextStyle(fontSize: 16, color: MyColors.grey070),
                        ),
                        trailing: Text(
                          data.deliveryTime!,
                          style: const TextStyle(fontSize: 16, color: MyColors.grey070),
                        ),
                      ),
                      const Divider(
                        height: 0,
                        indent: 30,
                        thickness: 0.9,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(MyIcons.moneyCheck, color: MyColors.grey070),
                        title: Text(
                          TranslationService.getString('minimum_key'),
                          style: const TextStyle(fontSize: 16, color: MyColors.grey070),
                        ),
                        trailing: Text(
                          '${data.minimum!}',
                          style: const TextStyle(fontSize: 16, color: MyColors.grey070),
                        ),
                      ),
                      const Divider(
                        height: 0,
                        indent: 30,
                        thickness: 0.9,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(MyIcons.dollar, color: MyColors.grey070),
                        title: Text(
                          TranslationService.getString('delivery_fee_key'),
                          style: const TextStyle(fontSize: 16, color: MyColors.grey070),
                        ),
                        trailing: Text(
                          '${data.deliveryFee!}',
                          style: const TextStyle(fontSize: 16, color: MyColors.grey070),
                        ),
                      ),
                      const Divider(
                        height: 0,
                        indent: 30,
                        thickness: 0.9,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(MyIcons.badgePercent, color: MyColors.grey070),
                        title: Text(
                          TranslationService.getString('sales_tax_key'),
                          style: const TextStyle(fontSize: 16, color: MyColors.grey070),
                        ),
                        trailing: Text(
                          '${data.salesTax!}%',
                          style: const TextStyle(fontSize: 16, color: MyColors.grey070),
                        ),
                      ),
                      const Divider(
                        height: 0,
                        indent: 30,
                        thickness: 0.9,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(MyIcons.basket, color: MyColors.grey070),
                        title: Text(
                          TranslationService.getString('sales_tax_key'),
                          style: const TextStyle(fontSize: 16, color: MyColors.grey070),
                        ),
                        trailing: Text(
                          data.isTaxable == 1 ? TranslationService.getString('yes_key') : TranslationService.getString('no_key'),
                          style: const TextStyle(fontSize: 16, color: MyColors.grey070),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const FailedWidget();
              }
          }
        });
  }
}
