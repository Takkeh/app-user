// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:takkeh/controller/view_product_ctrl.dart';
// import 'package:takkeh/model/restaurants/view_restaurant.dart';
// import 'package:takkeh/utils/base/colors.dart';
//
// class OptionalCheckBox extends StatefulWidget {
//   final int groupId;
//   final List<GroupItem> items;
//
//   const OptionalCheckBox({
//     Key? key,
//     required this.groupId,
//     required this.items,
//   }) : super(key: key);
//
//   @override
//   State<OptionalCheckBox> createState() => _OptionalCheckBoxState();
// }
//
// class _OptionalCheckBoxState extends State<OptionalCheckBox> {
//   final selectedItems = [];
//
//   void toggleGroupItem(String status, {required int itemId}) {
//     final group = {
//       "group_id": widget.groupId,
//       "item_id": itemId,
//     };
//     if (status == 'add') {
//       ViewProductCtrl.find.optionalGroupList.add(jsonEncode(group));
//     } else {
//       ViewProductCtrl.find.optionalGroupList.remove(jsonEncode(group));
//     }
//     log("Result:: ${ViewProductCtrl.find.optionalGroupList}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListBody(
//       children: widget.items.map((element) {
//         final itemId = element.id!;
//         final itemPrice = element.price!;
//         final title = element.name!;
//         return CheckboxListTile(
//           activeColor: MyColors.primary,
//           title: Text(
//             title,
//             style: const TextStyle(fontSize: 15, color: MyColors.grey),
//           ),
//           secondary: itemPrice == 0.0
//               ? null
//               : Text(
//                   itemPrice.toString(),
//                   style: const TextStyle(fontSize: 15, color: MyColors.grey),
//                 ),
//           controlAffinity: ListTileControlAffinity.leading,
//           value: selectedItems.contains(itemId),
//           onChanged: (value) {
//             if (selectedItems.contains(itemId)) {
//               setState(() {
//                 selectedItems.remove(itemId);
//               });
//               ViewProductCtrl.find.calculatePrice(itemPrice: itemPrice, status: 'remove');
//               toggleGroupItem('remove', itemId: itemId);
//             } else {
//               setState(() {
//                 selectedItems.add(itemId);
//               });
//               ViewProductCtrl.find.calculatePrice(itemPrice: itemPrice, status: 'add');
//               toggleGroupItem('add', itemId: itemId);
//             }
//           },
//         );
//       }).toList(),
//     );
//   }
// }
