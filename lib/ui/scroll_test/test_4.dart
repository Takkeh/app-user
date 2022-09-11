import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';

class Test4 extends StatefulWidget {
  const Test4({Key? key}) : super(key: key);

  @override
  _Test4State createState() => _Test4State();
}

class _Test4State extends State<Test4> {
  late ScrollController controller;
  int currentIndex = 0;
  List<GlobalKey> itemKeys = [];

  Future scrollToItem(index) async {
    await Scrollable.ensureVisible(
      itemKeys[index].currentContext!,
      alignment: 0.02,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    itemKeys = List.generate(100, (index) => GlobalKey());
    controller = ScrollController();
    controller.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scrollToItem(5);
        },
      ),
      appBar: AppBar(),
      body: InViewNotifierList(
        physics: const NeverScrollableScrollPhysics(),
        initialInViewIds: const ['0'],
        controller: controller,
        isInViewPortCondition: (double deltaTop, double deltaBottom, double vpHeight) {
          return deltaTop < (0.02 * vpHeight) && deltaBottom > (0.02 * vpHeight);
        },
        itemCount: 50,
        builder: (BuildContext context, int index) {
          return InViewNotifierWidget(
            id: '$index',
            builder: (BuildContext context, bool isInView, Widget? child) {
              if (isInView) {
                currentIndex = index;
                print("value:: $currentIndex");
              }
              return Container(
                key: itemKeys[index],
                margin: const EdgeInsets.all(00.0),
                color: isInView ? Colors.green : Colors.red,
                child: Column(
                  children: [
                    Text("Hello $index"),
                    Container(
                      alignment: Alignment.center,
                      height: 250.0,
                      child: Text(
                        isInView ? 'Is in view' : 'Not in view',
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
