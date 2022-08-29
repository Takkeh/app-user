import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/back_leading_widget.dart';

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
      elevation: 0,
      pinned: true,
      floating: true,
      leading: const BackLeadingWidget(icon: Icons.close),
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
