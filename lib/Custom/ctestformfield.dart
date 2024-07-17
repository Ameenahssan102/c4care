// ignore_for_file: prefer_const_constructors

import 'package:C4CARE/Values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CTextFormField extends StatelessWidget {
  final String placeholder;
  final void Function(String)? onChanged;
  final BoxDecoration? decoration;
  final Color? bordercolor;
  final Widget? icon;
  final Widget? suffix;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  const CTextFormField(
      {super.key,
      required this.placeholder,
      this.onChanged,
      this.bordercolor,
      this.decoration,
      this.icon,
      this.controller,
      this.suffix,
      this.textInputType});
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
        controller: controller,
        expands: true,
        minLines: null,
        maxLines: null,
        keyboardType: textInputType,
        style:
            GoogleFonts.montserrat(color: CupertinoColors.black, fontSize: 18),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        suffix: suffix,
        placeholderStyle: TextStyle(
          color: AppColors.hint.withOpacity(.6),
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
        cursorColor: CupertinoColors.black,
        cursorHeight: 22,
        prefix: icon != null
            ? CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white10,
                child: icon,
              )
            : SizedBox(),
        placeholder: placeholder,
        decoration: decoration ??
            BoxDecoration(
                border: Border.all(color: bordercolor ?? CupertinoColors.black),
                borderRadius: BorderRadius.circular(6.0)),
        onChanged: onChanged);
  }
}
