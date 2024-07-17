import 'package:C4CARE/Custom/ctext.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:flutter/material.dart';

class HCard extends StatelessWidget {
  final String text;
  final Widget step;
  final Widget count;
  const HCard({
    Key? key,
    required this.step,
    required this.text,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.primaryColor),
        color: AppColors.white,
      ),
      height: 100,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CText(
                  text: text,
                  textcolor: AppColors.primaryDarkColor,
                  size: Sizes.TEXT_SIZE_18,
                ),
                count
              ],
            ),
            Divider(
              color: AppColors.primaryDarkColor,
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            step,
          ],
        ),
      ),
    );
  }
}
