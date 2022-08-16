import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 50,
        width: 50,
        margin: const EdgeInsetsDirectional.fromSTEB(20, 5, 5, 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: MyColors.grey4F9.withOpacity(0.70),
          borderRadius: BorderRadius.circular(17),
        ),
        child: const Icon(
          Icons.search,
          color: MyColors.greyEB3,
        ),
      ),
    );
  }
}
