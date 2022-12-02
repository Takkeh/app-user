import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/addresses/my_addresses_ctrl.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/addresses/widgets/add_address_button.dart';
import 'package:takkeh/ui/screens/addresses/widgets/my_addresses_listview.dart';
import 'package:takkeh/ui/screens/addresses/widgets/no_addresses_widget.dart';
import 'package:takkeh/ui/widgets/custom_back_widget.dart';

class MyAddressesScreen extends StatelessWidget {
  const MyAddressesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAddressesCtrl>(
      builder: (controller) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: controller.myAddresses.isNotEmpty
              ? const AddNewAddressButton(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                )
              : null,
          appBar: AppBar(
            leading: const CustomBackWidget(),
            title: Text(TranslationService.getString('my_addresses_key')),
          ),
          body: controller.myAddresses.isEmpty ? const NoAddressesWidget() : const MyAddressesListViewBuilder(),
        );
      },
    );
  }
}
