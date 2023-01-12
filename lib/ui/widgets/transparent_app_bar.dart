import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/back_leading_widget.dart';
import 'package:takkeh/utils/base/colors.dart';

class TransparentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool withBackButton;

  const TransparentAppBar({super.key, this.title,this.withBackButton=true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 60,
      centerTitle: true,
      leading: withBackButton?const BackLeadingWidget():null,
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(
                color: MyColors.text,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
