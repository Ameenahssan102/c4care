import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../values/values.dart';

class Button extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color color;
  final Color textColor;
  final double width;
  final double height;

  const Button({
    Key? key,
    required this.title,
    required this.onPressed,
    this.color = AppColors.black,
    this.textColor = AppColors.white,
    this.width = double.infinity,
    this.height = 48,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        shadowColor: Colors.transparent,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
      onPressed: () {
        onPressed();
      },
      child: Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: 18.0,
          color: textColor,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }
}
