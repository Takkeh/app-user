import 'package:flutter/material.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';

class SearchSomethingWidget extends StatelessWidget {
  const SearchSomethingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          TranslationService.getString('search_something_key'),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: MyColors.grey070,
          ),
        ),
        const SizedBox(height: 20),
        Image.asset(
          MyImages.searchSomething,
          height: 200,
        ),
      ],
    );
  }
}
