// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class CElevatedButton extends StatelessWidget {
  final Widget text;
  final void Function() onpressed;
  final Color? color;
  final Color? discolor;
  final Size size;
  const CElevatedButton(
      {super.key,
      required this.text,
      required this.onpressed,
      this.color,
      this.discolor,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(elevation:MaterialStateProperty.all(0) ,
          fixedSize: MaterialStateProperty.all(size),
          padding: MaterialStateProperty.all(EdgeInsets.all(5)),
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)))),
      onPressed: onpressed,
      child: text,
    );
  }
}
