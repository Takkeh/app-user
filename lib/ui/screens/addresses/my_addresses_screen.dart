import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/addresses/my_addresses_ctrl.dart';
import 'package:takkeh/controller/user_location_ctrl.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/addresses/widgets/add_address_button.dart';
import 'package:takkeh/ui/screens/addresses/widgets/my_addresses_listview.dart';
import 'package:takkeh/ui/screens/addresses/widgets/no_addresses_widget.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';

class MyAddressesScreen extends StatefulWidget {
  const MyAddressesScreen({Key? key}) : super(key: key);

  @override
  State<MyAddressesScreen> createState() => _MyAddressesScreenState();
}

class _MyAddressesScreenState extends State<MyAddressesScreen> {
  @override
  void initState() {
    UserLocationCtrl.find.getPermission();
    super.initState();
  }

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
          appBar: TransparentAppBar(title: TranslationService.getString('my_addresses_key')),
          body: controller.myAddresses.isEmpty
              ? const NoAddressesWidget()
              : const MyAddressesListViewBuilder(
                  shrinkWrap: false,
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
        );
      },
    );
  }
}
