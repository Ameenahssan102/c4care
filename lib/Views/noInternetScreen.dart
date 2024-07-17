import 'package:C4CARE/Custom/base_widget.dart';
import 'package:C4CARE/Custom/custom_text.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:C4CARE/Views/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: BaseWidget(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 68.0),
              Lottie.asset('assets/lottie/nointernet.json',
                  width: size.width, repeat: true),
              const SizedBox(height: 24.0),
              Row(
                children: [
                  Expanded(
                      child: customText(
                          text: "No Internet Connection",
                          id: 2,
                          textSize: 17,
                          align: TextAlign.center,
                          color: AppColors.hint.withOpacity(.4))),
                ],
              ),
              const Text(
                'No internet connection found. Check your \n connection or try again!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                  onPressed: () async {
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
        ),
      ),
    );
  }
}
