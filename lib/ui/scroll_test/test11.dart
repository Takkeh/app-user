import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/ui/scroll_test/custom.dart';

class Test11 extends StatefulWidget {
  const Test11({Key? key}) : super(key: key);

  @override
  _Test11State createState() => _Test11State();
}

class _Test11State extends State<Test11> {
  List<GlobalKey> itemKeys = [];
  late ScrollController controller;
  int currentIndex = 0;

  Future scrollToItem(index) async {
    await Scrollable.ensureVisible(
      itemKeys[index].currentContext!,
      alignment: 0.02,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void detectPosition(int index) {
    RenderBox box = itemKeys[index].currentContext!.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(const Offset(0, -162.3));
    findHidden();
    print("value:: $position");
  }

  void findHidden() {
    int myIndex = 0;
    for (var element in itemKeys) {
      final index = itemKeys.indexOf(element);
      RenderBox box = element.currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(const Offset(0, -162.3));
      if (position.dy < 0) {
        print("result:: index:: $index");
        myIndex = index;
      }
    }
    TestIndex.find.getIndex(myIndex);
  }

  @override
  void initState() {
    super.initState();
    itemKeys = List.generate(50, (index) => GlobalKey());
    controller = ScrollController()
      ..addListener(() {
        findHidden();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scrollToItem(5);
          // detectPosition(0);
          print("keys:: ${itemKeys.length}");
        },
      ),
      body: CustomScrollView(
        controller: controller,
        slivers: [
          SliverAppBar(
            pinned: true,
            title: const Text(
              'SliverPersistentHeader Sample',
              style: TextStyle(
                fontFamily: 'Allison',
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.deepPurple,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://cdn.pixabay.com/photo/2016/09/10/17/18/book-1659717_960_720.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // const ACustomSliverHeader(
          //   backgroundColor: Colors.amber,
          //   headerTitle: 'First Sliver Persistent Header Sample',
          // ),
          GetBuilder<TestIndex>(
            init: TestIndex(),
            builder: (controller) {
              return ACustomSliverHeader(
                backgroundColor: Colors.green,
                headerTitle: 'Header:: ${controller.currentIndex.value}',
              );
            },
          ),
          SliverToBoxAdapter(
            child: Column(
              children: List.generate(
                50,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            detectPosition(index);
                          },
                          child: Text(
                            "position for $index",
                            key: itemKeys[index],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        ...List.generate(
                          5,
                          (index) {
                            return Container(
                              height: 50,
                              width: double.infinity,
                              color: Colors.red,
                              alignment: Alignment.center,
                              child: Text("number $index"),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TestIndex extends GetxController {
  static TestIndex get find => Get.find();

  final currentIndex = 0.obs;

  void getIndex(int index) {
    currentIndex.value = index;
    update();
  }
}
