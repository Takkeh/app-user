import 'package:flutter/material.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';

class NoResultSearchWidget extends StatelessWidget {
  const NoResultSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          TranslationService.getString('no_result_search_key'),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: MyColors.grey070,
          ),
        ),
        const SizedBox(height: 20),
        Image.asset(
          MyImages.noResultSearch,
          height: 200,
        ),
      ],
    );
  }
}
