import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/make_order.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/widgets/adress_widget.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class RestaurantsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext myContext;

  const RestaurantsAppBar({
    Key? key,
    required this.myContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: MyColors.redPrimary,
      leadingWidth: 60,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Card(
          color: MyColors.grey4F9.withOpacity(0.70),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: const Icon(
            Icons.navigate_before,
            color: Colors.white,
          ),
        ),
      ),
      title: const AddressWidget(),
      actions: [
        GetBuilder<UserOrderCtrl>(
          builder: (controller) {
            return GestureDetector(
              onTap: () {
                if (controller.orderList.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(TranslationService.getString('your_basket_is_empty_key')),
                    ),
                  );
                  return;
                }
                MakeOrderCtrl.find.fetchData(
                  context: myContext,
                  restaurantId: controller.restaurantId,
                  generalNote: '',
                  // route: BasketScreen(
                  //   restaurantId: restaurantId,
                  // ),
                );
              },
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topRight,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      MyIcons.shoppingCart,
                    ),
                  ),
                  Positioned(
                    right: -8,
                    top: 8,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 8,
                      child: Center(
                        child: Text(
                          controller.totalQuantity.value.toString(),
                          style: const TextStyle(color: MyColors.text),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(width: 15),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
