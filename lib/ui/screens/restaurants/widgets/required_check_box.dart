import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:takkeh/controller/view_product_ctrl.dart';
import 'package:takkeh/model/restaurants/view_restaurant.dart';
import 'package:takkeh/utils/base/colors.dart';

class RequiredCheckBox extends StatefulWidget {
  final int groupId;
  final List<GroupItem> items;

  const RequiredCheckBox({
    Key? key,
    required this.items,
    required this.groupId,
  }) : super(key: key);

  @override
  State<RequiredCheckBox> createState() => _RequiredCheckBoxState();
}

class _RequiredCheckBoxState extends State<RequiredCheckBox> {
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 5),
                child: InkWell(
                  onTap: () {
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
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedId == itemId ? MyColors.primary : MyColors.whiteFA,
                      border: Border.all(
                        color: MyColors.grey,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: selectedId == itemId
                          ? const Icon(
                              Icons.check,
                              size: 15.0,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.check_box_outline_blank,
                              size: 15.0,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 15, color: MyColors.grey),
              ),
              const Spacer(),
              Text(
                '+ $itemPrice JOD',
                style: const TextStyle(fontSize: 15, color: MyColors.grey),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
