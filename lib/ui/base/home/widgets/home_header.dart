import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 80),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 165,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: MyColors.primary,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(120),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Hi",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                " ${MySharedPreferences.name} ",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Text(
            "Hungry? ",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
