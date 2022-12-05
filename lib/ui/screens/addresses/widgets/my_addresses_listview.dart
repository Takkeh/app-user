import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/addresses/my_addresses_ctrl.dart';
import 'package:takkeh/utils/base/colors.dart';

class MyAddressesListViewBuilder extends StatelessWidget {
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  const MyAddressesListViewBuilder({
    Key? key,
    required this.shrinkWrap,
    this.physics,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAddressesCtrl>(
      builder: (controller) {
        return ListView.builder(
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding ?? EdgeInsets.zero,
          itemCount: controller.myAddresses.length,
          itemBuilder: (context, index) {
            final data = controller.myAddresses[index];
            return RadioListTile<int>(
              activeColor: MyColors.primary,
              title: Text(
                data.name!,
                style: const TextStyle(fontSize: 18),
              ),
              subtitle: Text('${data.region} ${data.street}'),
              controlAffinity: ListTileControlAffinity.leading,
              value: controller.selectedAddressId.value,
              onChanged: (int? value) {
                controller.selectAddress(data.id!);
              },
              groupValue: data.id,
            );
          },
        );
      },
    );
  }
}
