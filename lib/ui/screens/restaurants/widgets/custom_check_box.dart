import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class CustomCheckBox extends StatelessWidget {
  final String title, price;
  final bool value;
  final Function(bool?) onChanged;
  final OutlinedBorder? shape;

  const CustomCheckBox({
    Key? key,
    required this.title,
    required this.price,
    required this.onChanged,
    required this.value,
    required this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      leading: Transform.scale(
        scale: 1.2,
        child: SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            fillColor: MaterialStateProperty.all(MyColors.redD4F),
            side: const BorderSide(color: MyColors.redD4F),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: shape,
            value: value,
            onChanged: onChanged,
          ),
        ),
      ),
      trailing: Text(price),
    );
  }
}
