import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/helper/basket_helper.dart';
import 'package:takkeh/ui/widgets/address_widget.dart';
import 'package:takkeh/ui/widgets/custom_back_widget.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class RestaurantsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RestaurantsAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: MyColors.redPrimary,
      leadingWidth: 60,
      centerTitle: true,
      leading: const CustomBackWidget(),
      title: const AddressWidget(),
      actions: [
        GetBuilder<UserOrderCtrl>(
          builder: (controller) {
            return GestureDetector(
              onTap: () {
                BasketHelper.toggle(context, restaurantId: controller.restaurantId, surfaceType: kRawSnackBar);
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
