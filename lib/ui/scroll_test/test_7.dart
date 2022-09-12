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
      ),
    );
  }
}
