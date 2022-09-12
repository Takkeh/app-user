import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Test8 extends StatefulWidget {
  @override
  _Test8State createState() => _Test8State();
}

class _Test8State extends State<Test8> with SingleTickerProviderStateMixin {
  bool isCollapsed = false;
  late AutoScrollController scrollController;
  late TabController tabController;

  final double expandedHeight = 500.0;
  final double collapsedHeight = kToolbarHeight;

  final listViewKey = RectGetter.createGlobalKey();
  Map<int, dynamic> itemKeys = {};

  // prevent animate when press on tab bar
  bool pauseRectGetterIndex = false;

  @override
  void initState() {
    tabController = TabController(length: 30, vsync: this);
    scrollController = AutoScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    tabController.dispose();
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

  void onCollapsed(bool value) {
    if (isCollapsed == value) return;
    setState(() => isCollapsed = value);
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (pauseRectGetterIndex) return false;
    int lastTabIndex = tabController.length - 1;
    List<int> visibleItems = getVisibleItemsIndex();

    bool reachLastTabIndex = visibleItems.length <= 2 && visibleItems.last == lastTabIndex;
    if (reachLastTabIndex) {
      tabController.animateTo(lastTabIndex);
    } else {
      int sumIndex = visibleItems.reduce((value, element) => value + element);
      int middleIndex = sumIndex ~/ visibleItems.length;
      if (tabController.index != middleIndex) tabController.animateTo(middleIndex);
    }

    return false;
  }

  void animateAndScrollTo(int index) {
    pauseRectGetterIndex = true;
    tabController.animateTo(index);
    scrollController.scrollToIndex(index, preferPosition: AutoScrollPosition.begin).then((value) => pauseRectGetterIndex = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: RectGetter(
        key: listViewKey,
        child: NotificationListener<ScrollNotification>(
          onNotification: onScrollNotification,
          child: buildSliverScrollView(),
        ),
      ),
    );
  }

  Widget buildSliverScrollView() {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      controller: scrollController,
      slivers: [
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
        ),
        buildBody(),
      ],
    );
  }

  // SliverAppBar buildAppBar() {
  //   return FAppBar(
  //     data: data,
  //     context: context,
  //     scrollController: scrollController,
  //     expandedHeight: expandedHeight,
  //     collapsedHeight: collapsedHeight,
  //     isCollapsed: isCollapsed,
  //     onCollapsed: onCollapsed,
  //     tabController: tabController,
  //     onTap: (index) => animateAndScrollTo(index),
  //   );
  // }

  SliverList buildBody() {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(30, (index) {
          itemKeys[index] = RectGetter.createGlobalKey();
          return buildCategoryItem(index);
        }),
      ),
    );
  }

  Widget buildCategoryItem(int index) {
    return RectGetter(
      key: itemKeys[index],
      child: AutoScrollTag(
        key: ValueKey(index),
        index: index,
        controller: scrollController,
        child: Container(
          height: 100,
          color: Colors.red,
          width: double.infinity,
          alignment: Alignment.center,
          child: const Text("hello"),
        ),
      ),
    );
  }
}
