import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

class Test7 extends StatefulWidget {
  const Test7({Key? key}) : super(key: key);

  @override
  _Test7State createState() => _Test7State();
}

class _Test7State extends State<Test7> {
  final _keys = {};
  final scrollController = ScrollController();

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

      // if (itemRect != null && !(itemRect.top + 106 > rect!.bottom || itemRect.bottom < rect.top)) {
      //   print('TopItemRect:: ${itemRect.top} BottomItemRect:: ${itemRect.bottom}  TopRect:: ${rect.top} BottomRect:: ${rect.bottom}');
      //   items.add(index);
      // }
      // print('  TopRect:: ${rect!.top} BottomRect:: ${rect!.bottom}');

      if (itemRect != null && !(itemRect.top > rect!.bottom || itemRect.bottom < rect.top)) {
        //print('TopItemRect:: ${itemRect!.top} BottomItemRect:: ${itemRect.bottom}  TopRect:: ${rect!.top} BottomRect:: ${rect.bottom}');
        items.add(index);
        print(items);
      }
    });

    /// so all visible item's index are in this _items.
    return items;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      getVisible();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              toolbarHeight: kToolbarHeight + 50,
              pinned: true,
              expandedHeight: 470,
              collapsedHeight: kToolbarHeight + 50,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0.0),
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  width: double.infinity,
                  color: Colors.purple,
                  child: const Text("Hello"),
                ),
              ),
            ),
          ];
        },
        body: NotificationListener<ScrollUpdateNotification>(
          onNotification: (notification) {
            /// print all visible item's index when scroll updated.
            // print("getVisible:: ${getVisible()}");
            return true;
          },
          child: RectGetter(
            key: listViewKey,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 1000,
              itemBuilder: (BuildContext context, int index) {
                /// Make every item have the ability to get rect,
                /// and save keys for RectGetter and its index into _keys.
                _keys[index] = RectGetter.createGlobalKey();

                return RectGetter(
                  key: _keys[index],
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    height: 50.0 + ((27 * index) % 15) * 3.14,
                    // margin: const EdgeInsets.all(20.0),
                    color: Colors.primaries[index % Colors.primaries.length],
                    child: Text('$index'),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
