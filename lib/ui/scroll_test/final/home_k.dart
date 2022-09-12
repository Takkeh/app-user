import 'package:flutter/material.dart';
import 'package:takkeh/ui/scroll_test/final/flexibale_space_bar_header.dart';

class KHome extends StatefulWidget {
  const KHome({Key? key}) : super(key: key);

  @override
  _KHomeState createState() => _KHomeState();
}

class _KHomeState extends State<KHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const FlexibleSpaceBarHeader(),
          SliverPersistentHeader(
            pinned: true,
            delegate: HeaderSliver(),
          ),
        ],
      ),
    );
  }
}

const _maxHeaderExtent = 100.0;

class HeaderSliver extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / _maxHeaderExtent;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: _maxHeaderExtent,
            color: Colors.blue,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Icon(Icons.arrow_back),
                    Text("Food App"),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => _maxHeaderExtent;

  @override
  double get minExtent => _maxHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
