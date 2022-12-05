import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takkeh/utils/base/colors.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextDirection? textDirection;
  final TextInputType? keyboardType;
  final bool readOnly;
  final int maxLines;
  final int? minLines;
  final Function()? onTap;
  final Widget? suffixIcon;
  final AutovalidateMode? autoValidateMode;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final TextAlign? textAlign;
  final double? horizontalPadding;
  final double? minSuffixWidth;
  final double? maxSuffixWidth;
  final bool? filled;
  final EdgeInsetsGeometry? padding;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final String? initialValue;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.label,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.textDirection,
    this.keyboardType,
    this.readOnly = false,
    this.maxLines = 1,
    this.onTap,
    this.suffixIcon,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.labelStyle,
    this.hintStyle,
    this.prefixIcon,
    this.textAlign,
    this.horizontalPadding,
    this.minLines,
    this.inputFormatters,
    this.minSuffixWidth = 70,
    this.maxSuffixWidth = 70,
    this.filled,
    this.fillColor,
    this.padding,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  static const _border = 26.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        autovalidateMode: autoValidateMode,
        onTap: onTap,
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxLines,
        minLines: minLines,
        readOnly: readOnly,
        style: const TextStyle(color: MyColors.text, fontSize: 16),
        keyboardType: keyboardType,
        textDirection: textDirection,
        obscureText: obscureText,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          filled: filled,
          fillColor: fillColor,
          label: label == null ? null : Text(label!),
          hintText: hintText,
          hintStyle: hintStyle,
          labelStyle: const TextStyle(color: MyColors.greyED0),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0, vertical: 20),
          suffixIconConstraints: BoxConstraints(
            maxHeight: 50,
            minWidth: minSuffixWidth == null ? 70 : minSuffixWidth!,
            maxWidth: maxSuffixWidth == null ? 70 : maxSuffixWidth!,
          ),
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 50,
            minWidth: 70,
            maxWidth: 70,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_border),
            borderSide: const BorderSide(color: MyColors.grey9F4),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_border),
            borderSide: const BorderSide(color: MyColors.grey9F4),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_border),
            borderSide: const BorderSide(color: MyColors.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_border),
            borderSide: const BorderSide(color: Color(0xFFE70044)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_border),
            borderSide: const BorderSide(color: Color(0xFFE70044)),
          ),
          errorStyle: const TextStyle(color: Color(0xFFE70044)),
        ),
      ),
    );
  }
}
