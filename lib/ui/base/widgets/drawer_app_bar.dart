import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class DrawerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DrawerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 73,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          height: 50,
          width: 50,
          margin: const EdgeInsetsDirectional.fromSTEB(20, 5, 5, 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: MyColors.grey4F9.withOpacity(0.70),
            borderRadius: BorderRadius.circular(17),
          ),
          child: const Icon(
            Icons.navigate_before,
            color: MyColors.greyEB3,
          ),
        ),
      ),
      title: const Text(
        "Menu",
        style: TextStyle(
          color: MyColors.text,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
