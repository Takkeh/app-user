import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/user_location.dart';
import 'package:takkeh/ui/base/notifications.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_circular_progress_indicator.dart';
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
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.ideographic,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(MyIcons.marker),
          const SizedBox(width: 5),
          GetBuilder<UserLocationCtrl>(
            builder: (controller) {
              if (controller.locality.value == null || controller.subLocality.value == null) {
                return const CustomCircularProgressIndicator(color: Colors.white);
              }
              return Text(
                "${controller.locality.value}, ${controller.subLocality.value}",
              );
            },
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
          child: GestureDetector(
            onTap: () {
              Get.to(() => const NotificationsScreen());
            },
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
