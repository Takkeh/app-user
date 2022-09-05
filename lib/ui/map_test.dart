import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MapTest extends StatefulWidget {
  const MapTest({Key? key}) : super(key: key);

  @override
  State<MapTest> createState() => _MapTestState();
}

class _MapTestState extends State<MapTest> {
  final myList = [];

  final Map<String, dynamic> khaled = {
    "first": 44,
    "second": 789,
  };

  final Map<String, dynamic> saeed = {
    "first": 1,
    "second": 789,
  };

  @override
  void initState() {
    super.initState();
    myList.add(khaled);
    myList.add(saeed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(height: 100),
          ElevatedButton(
            onPressed: () {
              Map<String, dynamic> test = {
                "name": 'John',
                'age': 18,
              };
              List<Map<String, dynamic>> users = [
                {
                  "name": 'John',
                  'age': 18,
                },
                {
                  "name": 'Jane',
                  'age': 21,
                },
                {
                  "name": 'Mary',
                  'age': 23,
                },
                {
                  "name": 'Mary',
                  'age': 27,
                },
              ];
              for (var element in users) {
                bool isEqual = mapEquals(element, test);
                print("equalityTest:: $isEqual");
              }
            },
            child: const Text("Test"),
          ),
        ],
      ),
    );
  }
}
