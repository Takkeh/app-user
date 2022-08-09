import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.tertiary,
        child: Text(
          "Hi",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
