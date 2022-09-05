import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/wallet/widgets/delete_card_button.dart';
import 'package:takkeh/ui/screens/wallet/widgets/user_cards_slider.dart';
import 'package:takkeh/ui/screens/wallet/widgets/virtual_card_switch.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/colors.dart';

class PaymentOptionsScreen extends StatelessWidget {
  const PaymentOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blue6FA,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        width: Get.width - 100,
        title: TranslationService.getString('add_new_card_key'),
        onPressed: () {},
      ),
      appBar: TransparentAppBar(title: TranslationService.getString('payment_options_key')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 30),
        children: [
          const UserCardsSlider(),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(30, 40, 0, 15),
            child: Text(
              TranslationService.getString('card_options_key'),
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const VirtualCardSwitch(),
          const SizedBox(height: 10),
          const DeleteCardButton(),
        ],
      ),
    );
  }
}
