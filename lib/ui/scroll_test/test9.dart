import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Test9 extends StatefulWidget {
  const Test9({Key? key}) : super(key: key);

  @override
  State<Test9> createState() => _Test9State();
}

class _Test9State extends State<Test9> {
  late AutoScrollController scrollController;
  final listViewKey = RectGetter.createGlobalKey();
  Map<int, dynamic> itemKeys = {};

  @override
  void initState() {
    scrollController = AutoScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  List<int> getVisibleItemsIndex() {
    Rect? rect = RectGetter.getRectFromKey(listViewKey);
    List<int> items = [];
    if (rect == null) return items;
    itemKeys.forEach((index, key) {
      Rect? itemRect = RectGetter.getRectFromKey(key);
      if (itemRect == null) return;
      if (itemRect.top > rect.bottom) return;
      if (itemRect.bottom < rect.top) return;
      items.add(index);
    });
    return items;
  }

  // bool onScrollNotification(ScrollNotification notification) {
  //   if (pauseRectGetterIndex) return false;
  //   int lastTabIndex = tabController.length - 1;
  //   List<int> visibleItems = getVisibleItemsIndex();
  //
  //   bool reachLastTabIndex = visibleItems.length <= 2 && visibleItems.last == lastTabIndex;
  //   if (reachLastTabIndex) {
  //     tabController.animateTo(lastTabIndex);
  //   } else {
  //     int sumIndex = visibleItems.reduce((value, element) => value + element);
  //     int middleIndex = sumIndex ~/ visibleItems.length;
  //     if (tabController.index != middleIndex) tabController.animateTo(middleIndex);
  //   }
  //
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      controller: scrollController,
      slivers: [],
    );
  }
}
