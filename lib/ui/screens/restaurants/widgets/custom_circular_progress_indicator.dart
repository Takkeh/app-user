import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final Color? color;

  const CustomCircularProgressIndicator({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 25,
        width: 25,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: color,
        ),
      ),
    );
  }
}
