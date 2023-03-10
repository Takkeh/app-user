import 'package:flutter/material.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class SearchField extends StatelessWidget {
  final Function(String)? onChanged;
  final String hintText;
  final bool readOnly;
  final bool autofocus;
  final VoidCallback? onTap;

  const SearchField({
    Key? key,
    this.onChanged,
    required this.hintText,
    required this.readOnly,
    this.onTap,
    this.autofocus = false,
  }) : super(key: key);

  static const _border = 26.0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: MyColors.redPrimary,
      autofocus: autofocus,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const CustomPrefixIcon(icon: MyIcons.search),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 50,
          minWidth: 70,
          maxWidth: 70,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: BorderSide.none,
        ),
        errorStyle: const TextStyle(color: Color(0xFFD74545)),
      ),
    );
  }
}
