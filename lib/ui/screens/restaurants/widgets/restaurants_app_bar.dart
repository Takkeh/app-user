import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class RestaurantsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RestaurantsAppBar({Key? key}) : super(key: key);

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
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.ideographic,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(MyIcons.marker),
          const SizedBox(width: 5),
          const Text(
            "Amman, Khalda",
          ),
        ],
      ),
      actions: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topRight,
          children: [
            Center(
              child: SvgPicture.asset(
                MyIcons.shoppingCart,
              ),
            ),
            const Positioned(
              //TODO: check language change position + icon
              right: -8,
              top: 8,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 8,
                child: Center(
                  child: Text(
                    "5",
                    style: TextStyle(color: MyColors.text),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 15),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
