import 'package:flutter/material.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/addresses/widgets/add_address_button.dart';

class NoAddressesWidget extends StatelessWidget {
  const NoAddressesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            TranslationService.getString('you_dont_have_addresses_key'),
            style: const TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 30.0),
            child: Text(
              TranslationService.getString('lets_add_address_key'),
              style: const TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          const AddNewAddressButton(),
        ],
      ),
    );
  }
}
