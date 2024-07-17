import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final double size;

  const Avatar({Key? key, this.size = 56.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Image.asset(
          'assets/images/noimage.png',
          width: size,
          height: size,
        ));
  }
}
