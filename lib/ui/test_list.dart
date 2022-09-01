import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TestList extends StatefulWidget {
  const TestList({Key? key}) : super(key: key);

  @override
  State<TestList> createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  late ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  void scrollToIndex(int index) {
    itemScrollController.scrollTo(
      index: index,
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void initState() {
    super.initState();
    itemScrollController = ItemScrollController();
    itemPositionsListener.itemPositions.addListener(() {
      print("alifshafi ${itemPositionsListener.itemPositions.value.first.itemTrailingEdge} -- ${itemPositionsListener.itemPositions.value.first.index}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scrollToIndex(5);
        },
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
              ),
            ),
          ];
        },
        body: ScrollablePositionedList.builder(
          shrinkWrap: true,
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          itemCount: 50,
          itemBuilder: (context, index) {
            return Container(
              height: 100,
              margin: const EdgeInsets.all(16),
              color: Colors.red,
              child: Text('Item $index'),
            );
          },
        ),
      ),
    );
  }
}
