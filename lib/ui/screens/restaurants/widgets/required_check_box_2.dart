import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:takkeh/controller/view_product_ctrl.dart';
import 'package:takkeh/model/restaurants/groups_model.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_check_box.dart';

class RequiredCheckBox2 extends StatefulWidget {
  final int groupId;
  final List<ProductItems> items;

  const RequiredCheckBox2({
    Key? key,
    required this.items,
    required this.groupId,
  }) : super(key: key);

  @override
  State<RequiredCheckBox2> createState() => _RequiredCheckBox2State();
}

class _RequiredCheckBox2State extends State<RequiredCheckBox2> {
  int? selectedId;
  double? lastItemPrice;
  int? lastItemId;

  void toggleSelection(int? itemId) {
    setState(() {
      selectedId = itemId;
    });
  }

  void toggleGroupItem(String status, {required int itemId}) {
    final group = {
      "group_id": widget.groupId,
      "item_id": itemId,
    };
    if (status == 'add') {
      ViewProductCtrl.find.requiredGroupList.add(jsonEncode(group));
    } else {
      ViewProductCtrl.find.requiredGroupList.remove(jsonEncode(group));
    }
    log("Result:: ${ViewProductCtrl.find.requiredGroupList}");
  }

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: widget.items.map((element) {
        final itemId = element.id!;
        final itemPrice = element.price!;
        final title = element.name!;
        return CustomCheckBox(
          title: title,
          price: itemPrice,
          onChanged: (value) {
            if (selectedId == null) {
              toggleSelection(itemId);
              ViewProductCtrl.find.calculatePrice(itemPrice: itemPrice, status: 'add');
              toggleGroupItem('add', itemId: itemId);
            } else if (selectedId != itemId) {
              toggleSelection(itemId);
              ViewProductCtrl.find.calculatePrice(itemPrice: lastItemPrice!, status: 'remove');
              ViewProductCtrl.find.calculatePrice(itemPrice: itemPrice, status: 'add');
              toggleGroupItem('remove', itemId: lastItemId!);
              toggleGroupItem('add', itemId: itemId);
            } else if (selectedId == itemId) {
              toggleSelection(null);
              ViewProductCtrl.find.calculatePrice(itemPrice: itemPrice, status: 'remove');
              toggleGroupItem('remove', itemId: itemId);
            }
            lastItemPrice = itemPrice;
            lastItemId = itemId;
          },
          value: selectedId == itemId,
          shape: const CircleBorder(),
        );
      }).toList(),
    );
  }
}
