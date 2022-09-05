import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/wallet/deposite.dart';
import 'package:takkeh/ui/screens/wallet/payment_options.dart';
import 'package:takkeh/ui/screens/wallet/transactions.dart';
import 'package:takkeh/ui/screens/wallet/widgets/wallet_card.dart';
import 'package:takkeh/ui/screens/wallet/widgets/wallet_option_card.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blue6FA,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        width: Get.width - 100,
        title: TranslationService.getString('deposit_key'),
        onPressed: () {
          Get.to(() => const DepositScreen());
        },
      ),
      appBar: TransparentAppBar(title: TranslationService.getString('wallet_key')),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          WalletCard(
            amount: 96.5,
            onTap: () {},
          ),
          const SizedBox(height: 50),
          WalletOptionCard(
            title: TranslationService.getString('payment_options_key'),
            icon: MyIcons.wallet,
            onTap: () {
              Get.to(() => const PaymentOptionsScreen());
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: WalletOptionCard(
              title: TranslationService.getString('coupon_key'),
              icon: MyIcons.ticketBlack,
              onTap: () {},
            ),
          ),
          WalletOptionCard(
            title: TranslationService.getString('transactions_key'),
            icon: MyIcons.book,
            onTap: () {
              Get.to(() => const TransactionsScreen());
            },
          ),
        ],
      ),
    );
  }
}
