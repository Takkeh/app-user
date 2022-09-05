import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/screens/wallet/widgets/choose_card_list.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({Key? key}) : super(key: key);

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  late TextEditingController amountCtrl;

  @override
  void initState() {
    super.initState();
    amountCtrl = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    amountCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blue6FA,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        width: Get.width - 100,
        title: TranslationService.getString('deposit_key'),
        onPressed: () {},
      ),
      appBar: TransparentAppBar(title: TranslationService.getString('deposit_key')),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          Text(
            TranslationService.getString('transaction_amount_key'),
            style: const TextStyle(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 40, left: 15, right: 15),
            child: CustomTextField(
              filled: true,
              fillColor: Colors.white,
              controller: amountCtrl,
              label: TranslationService.getString('amount_key'),
              textDirection: TextDirection.ltr,
              keyboardType: TextInputType.number,
              prefixIcon: const CustomPrefixIcon(icon: MyIcons.currency),
              validator: (value) {
                if (value!.isEmpty) {
                  return TranslationService.getString('enter_money_amount_key');
                }
                return null;
              },
            ),
          ),
          Text(
            TranslationService.getString('choose_card_key'),
            style: const TextStyle(fontSize: 20),
          ),
          const ChooseCardList(),
        ],
      ),
    );
  }
}
