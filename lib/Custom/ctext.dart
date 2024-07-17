import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class CText extends StatelessWidget {
  final String text;
  final Color? textcolor;
  final FontWeight? fontw;
  final double? size;
  final bool? strike;
  final TextAlign? align;
  final int? maxlines;
  const CText(
      {super.key,
      required this.text,
      this.textcolor,
      this.fontw,
      this.size,
      this.strike,
      this.align, this.maxlines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
          decoration: strike == false
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          color: textcolor ?? CupertinoColors.black,
          fontWeight: fontw,
          fontSize: size),
      overflow: TextOverflow.clip,
      textAlign: align,
      maxLines: maxlines,
    );
  }
}
