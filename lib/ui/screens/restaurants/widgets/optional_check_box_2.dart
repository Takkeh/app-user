import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:takkeh/controller/view_product_ctrl.dart';
import 'package:takkeh/model/restaurants/view_restaurant.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_check_box.dart';

class OptionalCheckBox2 extends StatefulWidget {
  final int groupId;
  final List<GroupItem> items;

  const OptionalCheckBox2({
    Key? key,
    required this.groupId,
    required this.items,
  }) : super(key: key);

  @override
  State<OptionalCheckBox2> createState() => _OptionalCheckBox2State();
}

class _OptionalCheckBox2State extends State<OptionalCheckBox2> {
  final selectedItems = [];

  void toggleGroupItem(String status, {required int itemId}) {
    final group = {
      "group_id": widget.groupId,
      "item_id": itemId,
    };
    if (status == 'add') {
      ViewProductCtrl.find.optionalGroupList.add(jsonEncode(group));
    } else {
      ViewProductCtrl.find.optionalGroupList.remove(jsonEncode(group));
    }
    log("Result:: ${ViewProductCtrl.find.optionalGroupList}");
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
            if (selectedItems.contains(itemId)) {
              setState(() {
                selectedItems.remove(itemId);
              });
              ViewProductCtrl.find.calculatePrice(itemPrice: itemPrice, status: 'remove');
              toggleGroupItem('remove', itemId: itemId);
            } else {
              setState(() {
                selectedItems.add(itemId);
              });
              ViewProductCtrl.find.calculatePrice(itemPrice: itemPrice, status: 'add');
              toggleGroupItem('add', itemId: itemId);
            }
          },
          value: selectedItems.contains(itemId),
          shape: null,
        );
      }).toList(),
    );
  }
}
