import 'package:flutter/material.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/search_field.dart';
import 'package:takkeh/utils/base/colors.dart';

class SearchBubble extends StatelessWidget {
  final dynamic Function(String) onChanged;

  const SearchBubble({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.only(bottom: 30, right: 50, left: 50),
      decoration: const BoxDecoration(
        color: MyColors.redPrimary,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(150, 60),
        ),
      ),
      child: SearchField(
        autofocus: true,
        readOnly: false,
        hintText: TranslationService.getString('what_to_search_key'),
        onChanged: onChanged,
      ),
    );
  }
}
