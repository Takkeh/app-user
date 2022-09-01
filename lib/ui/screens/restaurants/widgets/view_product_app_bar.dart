import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/back_leading_widget.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/base/colors.dart';

class ViewProductAppBar extends StatelessWidget {
  final String imageUrl;

  const ViewProductAppBar({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 240,
      collapsedHeight: kToolbarHeight,
      leadingWidth: 70,
      backgroundColor: MyColors.redD4F,
      elevation: 0,
      pinned: true,
      floating: true,
      leading: const BackLeadingWidget(icon: Icons.close),
      flexibleSpace: FlexibleSpaceBar(
        background: CustomNetworkImage(
          url: imageUrl,
          radius: 0,
        ),
      ),
    );
  }
}
