import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class BarTest extends StatefulWidget {
  const BarTest({Key? key}) : super(key: key);

  @override
  State<BarTest> createState() => _BarTestState();
}

class _BarTestState extends State<BarTest> with TickerProviderStateMixin {
  late TabController _tabController;

  Widget getFilter() {
    return Container(
      color: Colors.teal,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () {},
            child: Text("Menu $index"),
          );
        },
      ),
    );
  }

  Widget getMostPopular() {
    return Container(
      // color: Colors.red,
      height: 165,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 115,
            padding: const EdgeInsets.only(bottom: 3),
            decoration: BoxDecoration(
              color: MyColors.grey9F4,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: NetworkImage("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Spicy Chiken",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const Text(
                  "18.3",
                  style: TextStyle(
                    fontSize: 15,
                    color: MyColors.redD4F,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildListView() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 20,
        (context, index) {
          return ListTile(
            leading: Text("Hello$index"),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            // toolbarHeight: 100,
            title: const Text("Test"),
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                padding: const EdgeInsets.only(top: 80, bottom: 60),
                child: getMostPopular(),
              ),
            ),
            expandedHeight: 300,
            collapsedHeight: kToolbarHeight + 50,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0.0),
              child: getFilter(),
            ),
          ),
          _buildListView(),
        ],
      ),
    );
  }
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  CustomSliverAppBarDelegate({required this.expandedHeight});

  // @override
  // Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    const size = 60;
    final top = expandedHeight - shrinkOffset - size / 2;

    return Container(
      color: Colors.red,
      height: 200,
      width: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Khaled app"),
            Text("Khaled app"),
            Text("Khaled app"),
            Text("Khaled app"),
            Text("Khaled app"),
          ],
        ),
      ),
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildAppBar(double shrinkOffset) => Opacity(
        opacity: appear(shrinkOffset),
        child: AppBar(
          title: Text("MyApp.title"),
          centerTitle: true,
        ),
      );

  Widget buildBackground(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Image.network(
          'https://source.unsplash.com/random?mono+dark',
          fit: BoxFit.cover,
        ),
      );

  Widget buildFloating(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Card(
          child: Row(
            children: [
              Expanded(child: buildButton(text: 'Share', icon: Icons.share)),
              Expanded(child: buildButton(text: 'Like', icon: Icons.thumb_up)),
            ],
          ),
        ),
      );

  Widget buildButton({
    required String text,
    required IconData icon,
  }) =>
      TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Text(text, style: TextStyle(fontSize: 20)),
          ],
        ),
        onPressed: () {},
      );

  @override
  // TODO: implement maxExtent
  double get maxExtent => expandedHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}
