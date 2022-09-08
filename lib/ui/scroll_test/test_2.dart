import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Test2 extends StatefulWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  late ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    itemScrollController = ItemScrollController();
    itemPositionsListener.itemPositions.addListener(() {
      print("value:: ${itemPositionsListener.itemPositions.value.first.index}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          itemScrollController.scrollTo(
            index: 10,
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOutCubic,
          );
        },
      ),
      appBar: AppBar(),
      body: ScrollablePositionedList.builder(
        shrinkWrap: true,
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        itemCount: 50,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              height: 200,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(16),
              color: Colors.teal,
              child: Text('Item $index'),
            );
          }
          return Container(
            height: 100,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(16),
            color: Colors.red,
            child: Text('Item $index'),
          );
        },
      ),
    );
  }
}
