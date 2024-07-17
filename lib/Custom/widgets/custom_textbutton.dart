import 'package:flutter/material.dart';
import '../../values/values.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color color;
  final Color textColor;
  final double? width;

  const CustomTextButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.color = Colors.blue,
      this.textColor = AppColors.black,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 48.0,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          // style: TextStyles.mediumBold(color: textColor),
        ),
      ),
    );
  }
}
