import 'package:flutter/material.dart';

class QuantityButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;
  final Color color;

  const QuantityButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        maximumSize: const Size(30, 30),
        backgroundColor: color,
        minimumSize: const Size(30, 30),
        padding: EdgeInsets.zero,
      ),
      onPressed: onPressed,
      child: Icon(
        icon,
      ),
    );
  }
}
