import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Values/values.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Color color;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool readOnly;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const CustomTextFormField(
      {Key? key,
      required this.hint,
      this.controller,
      this.focusNode,
      this.color = Colors.black,
      this.readOnly = false,
      this.onTap,
      this.onChanged,
      this.suffixIcon,
      this.maxLength,
      this.keyboardType,
      this.validator,
      this.textCapitalization = TextCapitalization.none,
      this.inputFormatters,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      textInputAction: TextInputAction.next,
      autofocus: false,
      onTap: onTap,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onChanged: onChanged,
      readOnly: readOnly,
      focusNode: focusNode,
      maxLength: maxLength,
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: 18.0,
        color: color,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        labelText: hint,
        labelStyle: const TextStyle(
          fontSize: 18.0,
          color: AppColors.hint,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: color,
            width: 2.0,
          ),
        ),
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
