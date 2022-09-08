import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Test3 extends StatefulWidget {
  const Test3({Key? key}) : super(key: key);

  @override
  State<Test3> createState() => _Test3State();
}

class _Test3State extends State<Test3> {
  final scrollDirection = Axis.vertical;

  late AutoScrollController controller;
  late List<List<int>> randomList;

  Future _scrollToIndex() async {
    await controller.scrollToIndex(10, preferPosition: AutoScrollPosition.begin);
  }

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
    );
    controller.addListener(() {
      print("value:: ${controller.isIndexStateInLayoutRange(15)}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _scrollToIndex,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(),
      body: ListView(
        scrollDirection: scrollDirection,
        controller: controller,
        children: <Widget>[
          ...List.generate(20, (index) {
            return AutoScrollTag(
              key: ValueKey(index),
              controller: controller,
              index: index,
              highlightColor: Colors.black.withOpacity(0.1),
              child: Container(
                height: 100,
                color: Colors.red,
                margin: const EdgeInsets.all(10),
                child: Center(child: Text('index: $index')),
              ),
            );
          }),
        ],
      ),
    );
  }
}
