import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/utils/base/colors.dart';

class DrawerListTile extends StatelessWidget {
  final String title, icon;
  final Function() onTap;

  const DrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        child: SvgPicture.asset(
          icon,
          color: MyColors.text,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
