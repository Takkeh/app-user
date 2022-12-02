import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/addresses/my_addresses_ctrl.dart';

class MyAddressesListViewBuilder extends StatelessWidget {
  const MyAddressesListViewBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAddressesCtrl>(
      builder: (controller) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          itemCount: controller.myAddresses.length,
          itemBuilder: (context, index) {
            final data = controller.myAddresses[index];
            return CheckboxListTile(
              title: Text(
                data.name!,
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Text('${data.region} ${data.street}'),
              controlAffinity: ListTileControlAffinity.leading,
              value: controller.selectedAddressId.value == data.id,
              onChanged: (bool? value) {
                controller.selectAddress(data.id!);
              },
            );
          },
        );
      },
    );
  }
}
