import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/utils/base/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 73,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          height: 50,
          width: 50,
          margin: const EdgeInsetsDirectional.fromSTEB(20, 5, 5, 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: MyColors.grey5FA,
            borderRadius: BorderRadius.circular(17),
          ),
          child: const Icon(
            Icons.navigate_before,
            color: MyColors.greyEB3,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
