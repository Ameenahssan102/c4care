import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../values/values.dart';

class ButtonOutlined extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color color;
  final Color bgColor;
  final Color textColor;
  final double width;
  final double height;
  final TextStyle? style;

  const ButtonOutlined(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.color = AppColors.dark,
      this.textColor = AppColors.white,
      this.width = double.infinity,
      this.height = 48,
      this.bgColor = Colors.transparent,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = GoogleFonts.roboto(
      fontSize: 18.0,
      color: textColor,
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
    );
    if (this.style != null) {
      style = this.style!;
    }

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: bgColor,
        side: BorderSide(width: 1.2, color: color),
        minimumSize: Size(width, height),
      ),
      onPressed: () => onPressed(),
      child: Text(
        title,
        style: style,
      ),
    );
  }
}
