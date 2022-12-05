import 'package:flutter/material.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 60),
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
          //TODO: check if this will appear on change like edit profile and guest sign in + handle notifications icon
          if (MySharedPreferences.isLogIn)
            Row(
              children: [
                const Text(
                  "Hi",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  " ${MySharedPreferences.name} ",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          Text(
            TranslationService.getString('home_welcome_text_key'),
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
