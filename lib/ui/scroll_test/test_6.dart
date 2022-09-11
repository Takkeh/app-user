import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

class TestTest8 extends StatefulWidget {
  TestTest8({Key? key}) : super(key: key);

  @override
  TestTest8State createState() => TestTest8State();
}

class TestTest8State extends State<TestTest8> {
  final _keys = {};

  @override
  Widget build(BuildContext context) {
    /// Make the entire ListView have the ability to get rect.
    var listViewKey = RectGetter.createGlobalKey();

    List<int> getVisible() {
      /// First, get the rect of ListView, and then traver the _keys
      /// get rect of each item by keys in _keys, and if this rect in the range of ListView's rect,
      /// add the index into result list.
      var rect = RectGetter.getRectFromKey(listViewKey);
      var items = <int>[];
      _keys.forEach((index, key) {
        var itemRect = RectGetter.getRectFromKey(key);
        if (itemRect != null && !(itemRect.top > rect!.bottom || itemRect.bottom < rect.top)) {
          print('TopItemRect:: ${itemRect.top} BottomItemRect:: ${itemRect.bottom}  TopRect:: ${rect.top} BottomRect:: ${rect.bottom}');

          items.add(index);
        }
      });

      /// so all visible item's index are in this _items.
      return items;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
      ),
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          /// print all visible item's index when scroll updated.
          print("getVisible:: ${getVisible()}");
          return true;
        },
        child: RectGetter(
          key: listViewKey,
          child: ListView.builder(
            itemCount: 1000,
            itemBuilder: (BuildContext context, int index) {
              /// Make every item have the ability to get rect,
              /// and save keys for RectGetter and its index into _keys.
              _keys[index] = RectGetter.createGlobalKey();
              return RectGetter(
                key: _keys[index],
                child: Container(
                  color: Colors.primaries[index % Colors.primaries.length],
                  child: SizedBox(
                    width: 100.0,

                    /// random height
                    height: 50.0 + ((27 * index) % 15) * 3.14,
                    child: Center(
                      child: Text('$index'),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
