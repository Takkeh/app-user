import 'package:flutter/material.dart';

class NoItemsFoundWidget extends StatelessWidget {
  final String text;

  const NoItemsFoundWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20),
      textAlign: TextAlign.center,
    );
  }
}
