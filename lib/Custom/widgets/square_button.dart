import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final Widget child;

  final double size;
  final VoidCallback onPressed;
  final Color? fillColor;

  const SquareButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.size = 40.0,
    this.fillColor = Colors.green,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero, backgroundColor: fillColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
        onPressed: () => onPressed(),
        child: child,
      ),
    );
  }
}
