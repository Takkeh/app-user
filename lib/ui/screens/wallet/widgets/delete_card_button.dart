import 'package:flutter/material.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/utils/base/colors.dart';

class DeleteCardButton extends StatelessWidget {
  const DeleteCardButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 45),
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(26),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(37, 23, 20, 23),
            child: Text(
              TranslationService.getString('delete_card_from_account_key'),
              style: const TextStyle(color: MyColors.redD4F),
            ),
          ),
        ),
      ),
    );
  }
}
