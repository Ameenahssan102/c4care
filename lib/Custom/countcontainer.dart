import 'package:C4CARE/Custom/ctext.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:flutter/material.dart';

class CountC extends StatelessWidget {
  final Offset offset;
  final double? width;
  final String count;
  final String type;
  const CountC(
      {Key? key,
      required this.offset,
      required this.count,
      this.width,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        width: width,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            // boxShadow: [
            //   BoxShadow(
            //       color: AppColors.hint.withOpacity(0.2),
            //       offset: const Offset(0, 3),
            //       blurRadius: 2,
            //       spreadRadius: 0.4)
            // ],
            gradient: LinearGradient(colors: [
              AppColors.primaryColor.withOpacity(0.3),
              AppColors.primaryDarkColor.withOpacity(0.8)
            ])),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CText(
                text: count.toString(),
                textcolor: AppColors.white,
                size: 24,
                fontw: FontWeight.w800,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              CText(
                text: type,
                size: Sizes.TEXT_SIZE_18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
