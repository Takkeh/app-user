import 'package:flutter/material.dart';

class FailedWidget extends StatelessWidget {
  const FailedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Center(
        child: Text("Something went wrong!"),
      ),
    );
  }
}
