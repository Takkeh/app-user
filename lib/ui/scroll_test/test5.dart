import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class Test5 extends StatefulWidget {
  const Test5({Key? key}) : super(key: key);

  @override
  _Test5State createState() => _Test5State();
}

class _Test5State extends State<Test5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
      ),
      body: PageView.builder(
          padEnds: false,
          scrollDirection: Axis.vertical,
          itemCount: 5,
          controller: PageController(
            viewportFraction: 0.5,
          ),
          pageSnapping: false,
          onPageChanged: (index) {
            print("value:: $index");
          },
          allowImplicitScrolling: true,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(5),
              alignment: Alignment.center,
              height: 200,
              width: double.infinity,
              color: MyColors.primary,
              child: Text("Hello $index"),
            );
          }),
    );
  }
}
