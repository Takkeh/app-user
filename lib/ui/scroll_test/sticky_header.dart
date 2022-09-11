import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:takkeh/utils/base/colors.dart';

class StickyHeader extends StatefulWidget {
  const StickyHeader({Key? key}) : super(key: key);

  @override
  State<StickyHeader> createState() => _StickyHeaderState();
}

class _StickyHeaderState extends State<StickyHeader> {
  late StickyHeaderController stickyHeaderController;

  @override
  void initState() {
    super.initState();
    stickyHeaderController = StickyHeaderController();
    stickyHeaderController.addListener(() {
      print("headers:: ${stickyHeaderController.stickyHeaderScrollOffset}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 200,
            collapsedHeight: kToolbarHeight + 50,
            pinned: true,
            backgroundColor: MyColors.redD4F,
          ),
          SliverStickyHeader.builder(
            overlapsContent: true,
            builder: (context, state) => Container(
              height: 60.0,
              color: (state.isPinned ? Colors.pink : Colors.lightBlue).withOpacity(1.0 - state.scrollPercentage),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Header #1',
                style: TextStyle(color: Colors.white),
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Text('0'),
                    ),
                    title: Text('List tile #$i'),
                  );
                },
                childCount: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
