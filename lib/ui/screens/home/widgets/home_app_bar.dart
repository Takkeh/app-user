import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/helper/location_permission_helper.dart';
import 'package:takkeh/ui/screens/addresses/my_addresses_screen.dart';
import 'package:takkeh/ui/widgets/address_widget.dart';
import 'package:takkeh/utils/base/icons.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 45,
      centerTitle: true,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
        child: GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: SvgPicture.asset(
            MyIcons.menu,
            height: 20,
          ),
        ),
      ),
      title: const AddressWidget(),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
          child: GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              MyIcons.bell,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
