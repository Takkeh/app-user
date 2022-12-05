import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            "or",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
