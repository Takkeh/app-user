import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/addresses.dart';
import 'package:takkeh/controller/user_location_ctrl.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/addresses/add_new_address_screen.dart';
import 'package:takkeh/ui/widgets/back_leading_widget.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/utils/base/colors.dart';

class PickAddressDialog extends StatefulWidget {
  const PickAddressDialog({Key? key}) : super(key: key);

  @override
  State<PickAddressDialog> createState() => _PickAddressDialogState();
}

class _PickAddressDialogState extends State<PickAddressDialog> {
  String? selectedText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const BackLeadingWidget(icon: Icons.close),
            Center(
              child: Text(
                TranslationService.getString("select_address_key"),
                style: const TextStyle(
                  color: MyColors.redPrimary,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        ...List.generate(
          UserLocationCtrl.find.savedAddresses.length,
          (index) {
            return ListTile(
              title: Text(UserLocationCtrl.find.savedAddresses[index]),
              leading: Radio<String>(
                fillColor: MaterialStateProperty.all(MyColors.redPrimary),
                activeColor: MyColors.redPrimary,
                value: UserLocationCtrl.find.savedAddresses[index],
                groupValue: selectedText,
                onChanged: (String? value) {
                  setState(() {
                    selectedText = value!;
                  });
                },
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        CustomElevatedButton(
          title: TranslationService.getString("confirm_address_key"),
          width: double.maxFinite,
          color: MyColors.redPrimary,
          textColor: Colors.white,
          onPressed: () {
            Get.back();
            Get.to(() => const AddNewAddressScreen(), binding: CreateAddressBinding());
          },
        ),
      ],
    );
  }
}
