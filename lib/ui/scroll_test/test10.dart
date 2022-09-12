import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

class Test10 extends StatefulWidget {
  const Test10({Key? key}) : super(key: key);

  @override
  _Test10State createState() => _Test10State();
}

class _Test10State extends State<Test10> {
  final _keys = {};
  final scrollController = ScrollController();

  var listViewKey = RectGetter.createGlobalKey();

  List<int> getVisible() {
    var rect = RectGetter.getRectFromKey(listViewKey);
    var items = <int>[];
    _keys.forEach((index, key) {
      var itemRect = RectGetter.getRectFromKey(key);

      if (itemRect != null && !(itemRect.top > rect!.bottom || itemRect.bottom < rect.top)) {
        //bottomRREct = 866
        //TopRect = 216
        if (rect.top == 5.684341886080802e-14) {
          print("alsifjasfil");
        }
        print('TopItemRect:: ${itemRect.top} BottomItemRect:: ${itemRect.bottom}  TopRect:: ${rect.top} BottomRect:: ${rect.bottom}');
        items.add(index);
        print(items);
      }
    });

    return items;
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      getVisible();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          print("getVisible:: ${getVisible()}");
          return true;
        },
        child: RectGetter(
          key: listViewKey,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 1000,
            itemBuilder: (BuildContext context, int index) {
              _keys[index] = RectGetter.createGlobalKey();

              if (index == 0) {
                return RectGetter(
                  key: _keys[index],
                  child: Container(
                    height: 300,
                    color: Colors.black,
                  ),
                );
              }
              return RectGetter(
                key: _keys[index],
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: 50.0 + ((27 * index) % 15) * 3.14,
                  color: Colors.primaries[index % Colors.primaries.length],
                  child: Text('$index'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
