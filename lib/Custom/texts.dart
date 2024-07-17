import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Values/values.dart';

class Texts {
  static Text badge(
    text, {
    Color color = AppColors.black,
  }) {
    return Text(text,
        style: GoogleFonts.roboto(
          fontSize: 14.0,
          color: color,
          fontStyle: FontStyle.normal,
        ));
  }

  static Text totalPrice(text, {Color color = AppColors.black}) {
    return Text(text,
        style: GoogleFonts.roboto(
          fontSize: 30.0,
          color: color,
          fontWeight: FontWeight.w800,
          fontStyle: FontStyle.normal,
        ));
  }

  static Text extraLarge(text, {Color color = AppColors.black}) {
    return Text(text,
        style: GoogleFonts.roboto(
          fontSize: 24.0,
          color: color,
          fontStyle: FontStyle.normal,
        ));
  }

  static Text extraLargeBold(text, {Color color = AppColors.black}) {
    return Text(text,
        style: GoogleFonts.roboto(
          fontSize: 24.0,
          color: color,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
        ));
  }

  static Text large(text, {Color color = AppColors.black}) {
    return Text(text,
        style: GoogleFonts.roboto(
          fontSize: 22.0,
          color: color,
          fontStyle: FontStyle.normal,
        ));
  }

  static Text largeBold(text, {Color color = AppColors.black}) {
    return Text(text,
        style: GoogleFonts.roboto(
          fontSize: 22.0,
          color: color,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
        ));
  }

  static Text mediumText(text, {Color color = AppColors.black}) {
    return Text(text,
        style: GoogleFonts.roboto(
          fontSize: 20.0,
          color: color,
          fontStyle: FontStyle.normal,
        ));
  }

  static Text mediumBold(text, {Color color = AppColors.black, maxLines}) {
    return Text(text,
        maxLines: maxLines,
        style: GoogleFonts.roboto(
          fontSize: 20.0,
          color: color,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
        ));
  }

  static Text regular(text, {Color color = AppColors.black, maxLines}) {
    return Text(text,
        maxLines: maxLines,
        style: GoogleFonts.roboto(
          fontSize: 18.0,
          color: color,
          fontStyle: FontStyle.normal,
        ));
  }

  static Text regularBold(text, {Color color = AppColors.black, maxLines}) {
    return Text(text,
        maxLines: maxLines,
        style: GoogleFonts.roboto(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: color,
          fontStyle: FontStyle.normal,
        ));
  }

  static Container regularBox(
    text, {
    Color textColor = AppColors.white,
    Color bgColor = AppColors.black,
    double borderRadius = 2.0,
    maxLines,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      decoration: Decorations.boxDecorationColorBorder(
          color: bgColor, borderRadius: borderRadius),
      // padding: Dimensions.padding_symmetric_6_2,
      margin: margin,
      child: Text(text,
          maxLines: maxLines,
          style: GoogleFonts.roboto(
            fontSize: 18.0,
            color: textColor,
            fontStyle: FontStyle.normal,
          )),
    );
  }

  static Text small(text, {Color color = AppColors.black, maxLines}) {
    return Text(text,
        maxLines: maxLines,
        style: GoogleFonts.roboto(
          fontSize: 16.0,
          color: color,
          fontStyle: FontStyle.normal,
        ));
  }

  static Container smallBox(text,
      {Color textColor = AppColors.white,
      Color bgColor = AppColors.black,
      double borderRadius = 2.0,
      maxLines,
      EdgeInsetsGeometry? margin}) {
    return Container(
      margin: margin,
      decoration: Decorations.boxDecorationColorBorder(
          color: bgColor, borderRadius: borderRadius),
      // padding: Dimensions.padding_symmetric_6_2,
      child: Text(text,
          maxLines: maxLines,
          style: GoogleFonts.roboto(
            fontSize: 16.0,
            color: textColor,
            fontStyle: FontStyle.normal,
          )),
    );
  }

  static Text thin(text, {Color color = AppColors.black}) {
    return Text(text,
        style: GoogleFonts.roboto(
          fontSize: 14.0,
          color: color,
          fontStyle: FontStyle.normal,
        ));
  }

  static Container thinBox(
    text, {
    Color textColor = AppColors.white,
    Color bgColor = AppColors.black,
    double borderRadius = 2.0,
    maxLines,
  }) {
    return Container(
      decoration: Decorations.boxDecorationColorBorder(
          color: bgColor, borderRadius: borderRadius),
      // padding: Dimensions.padding_symmetric_6_2,
      child: Text(text,
          maxLines: maxLines,
          style: GoogleFonts.roboto(
            fontSize: 14.0,
            color: textColor,
            fontStyle: FontStyle.normal,
          )),
    );
  }
}
