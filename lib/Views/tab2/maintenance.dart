import 'package:C4CARE/Views/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../../Custom/base_widget.dart';
import '../../../Custom/custom_text.dart';
import '../../../Values/values.dart';

class AppMaintenance extends StatelessWidget {
  final String message;

  const AppMaintenance({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BaseWidget(
        child: Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 68.0),
          Lottie.asset('assets/lottie/maintenance.json',
              width: size.width, repeat: true),
          const SizedBox(height: 24.0),
          Row(
            children: [
              Expanded(
                  child: customText(
                      text: message,
                      id: 2,
                      textSize: 17,
                      align: TextAlign.center,
                      color: AppColors.hint.withOpacity(.4))),
            ],
          ),
          const SizedBox(height: 68.0),
          ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Splash()),
                    (route) => false);
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize: Size(size.width, 60),
                  backgroundColor: AppColors.primaryDarkColor,
                  textStyle: GoogleFonts.lato(fontSize: 20)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.repeat, color: AppColors.white),
                  SizedBox(
                    width: 10,
                  ),
                  customText(
                    text: "RETRY",
                    id: 1,
                    color: AppColors.white,
                  ),
                ],
              ))
        ],
      ),
    ));
  }
}
