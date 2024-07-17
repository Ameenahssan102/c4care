import 'package:C4CARE/Custom/texts.dart';
import 'package:flutter/material.dart';
import '../../values/values.dart';
import 'custom_textbutton.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String? message;
  final String yesText;
  final String? noText;
  final VoidCallback? yesOnPressed;
  final VoidCallback? noOnPressed;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.yesText,
    this.noText,
    this.yesOnPressed,
    this.noOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Texts.mediumBold(title, color: AppColors.black),
      content: message != null ? Texts.regular(message, color: AppColors.black) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      actions: <Widget>[
        CustomTextButton(
          title: yesText,
          onPressed: yesOnPressed,
          color: Colors.transparent,
        ),
        if (noText != null) CustomTextButton(title: noText!, onPressed: noOnPressed, color: Colors.transparent),
      ],
    );
  }
}
