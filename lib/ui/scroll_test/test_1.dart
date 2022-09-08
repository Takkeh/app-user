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
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    itemScrollController = ItemScrollController();
    itemPositionsListener.itemPositions.addListener(() {
      setState(() {
        print("alifshafi ${itemPositionsListener.itemPositions.value.first.itemTrailingEdge} -- ${itemPositionsListener.itemPositions.value.first.index}");
        currentIndex = itemPositionsListener.itemPositions.value.first.index;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void scrollToIndex(int index) {
    itemScrollController.scrollTo(
      index: index,
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scrollToIndex(5);
        },
      ),
      appBar: AppBar(
        toolbarHeight: currentIndex > 0 ? kToolbarHeight + 50 : kToolbarHeight,
        elevation: 10,
        backgroundColor: Colors.orange,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: currentIndex > 0
              ? Container(
                  key: const ValueKey('1'),
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.zero,
                  color: Colors.orange,
                  child: const Text('stack bottom'),
                )
              : const SizedBox.shrink(key: ValueKey('2')),
        ),
      ),
      body: ScrollablePositionedList.builder(
        shrinkWrap: true,
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        itemCount: 50,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              height: 350,
              color: Colors.blue,
              child: Text('Item $index'),
            );
          } else if (index == 1) {
            return currentIndex > 0
                ? const SizedBox.shrink()
                : Container(
                    height: 50,
                    color: Colors.orange,
                    child: Text('Item $index'),
                  );
          }
          return Container(
            height: 100,
            margin: const EdgeInsets.all(16),
            color: Colors.red,
            child: Text('Item $index'),
          );
        },
      ),
    );
  }
}
