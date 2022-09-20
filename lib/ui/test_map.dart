import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TestMap extends StatefulWidget {
  const TestMap({Key? key}) : super(key: key);

  @override
  State<TestMap> createState() => _TestMapState();
}

class _TestMapState extends State<TestMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final myMap = {
              'product_id': 1,
              'quantity': 3,
              'extras': [
                {'extra_id': 1}
              ],
              'size_id': 5,
              'note': "note",
              'price': 200,
            };
            final List<Map<String, dynamic>> list = [
              {
                'product_id': 1,
                'quantity': 3,
                'extras': [
                  {'extra_id': 1}
                ],
                'size_id': 1,
                'note': "note",
                'price': 200,
              },
              {
                'product_id': 1,
                'quantity': 3,
                'extras': [
                  {'extra_id': 1}
                ],
                'size_id': 1,
                'note': "note",
                'price': 200,
              },
            ];
            if (myMap.toString() == list[0].toString()) {
              print("Yes Yes");
            } else {
              print("No No");
            }
            // for (var element in list) {
            //   if (mapEquals(element, myMap)) {
            //     print('$element:: yes');
            //   } else {
            //     print('$element:: no');
            //   }
            // }
          },
          child: const Text("Test"),
        ),
      ),
    );
  }
}
