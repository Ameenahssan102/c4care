// ignore_for_file: use_build_context_synchronously

import 'package:C4CARE/Custom/custom_text.dart';
import 'package:C4CARE/Custom/slide_right_route.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:C4CARE/Views/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: OnBoardingSlider(
        headerBackgroundColor: Colors.white,
        finishButtonText: "Get started",
        centerBackground: true,
        controllerColor: AppColors.hint.withOpacity(.2),
        finishButtonStyle: FinishButtonStyle(
            backgroundColor: AppColors.primaryDarkColor, elevation: 3),
        skipTextButton: const Text('Skip'),
        trailing: const Text(''),
        onFinish: () async {
          final sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setBool('seenOnboarding', true);
          Navigator.pushAndRemoveUntil(context,
              SlideRightRoute(page: const LoginScreen()), (route) => false);
        },
        background: [
          Image.asset('assets/images/onboard1.png'),
          Image.asset('assets/images/onboard2.png'),
          Image.asset('assets/images/onboard3.png'),
          Image.asset('assets/images/onboard4.png'),
          Image.asset('assets/images/onboard5.png'),
        ],
        totalPage: 5,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 420,
                ),
                customText(
                  text: 'Welcome to\n  C4CARE, ',
                  id: 2,
                  weight: FontWeight.bold,
                  textSize: 19,
                  align: TextAlign.center,
                ),
                customText(
                  align: TextAlign.center,
                  text:
                      'brought to you by Care for Consulting Ltd. Your all-in-one solution for managing your work-life in the world of healthcare.',
                  id: 2,
                  weight: FontWeight.bold,
                  textSize: 17,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                customText(
                    weight: FontWeight.bold,
                    textSize: 17,
                    align: TextAlign.center,
                    text:
                        'Seamlessly navigate your employee profile, making it easier than ever to stay updated with your professional information.',
                    id: 2),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                customText(
                    weight: FontWeight.bold,
                    align: TextAlign.center,
                    textSize: 17,
                    text:
                        'Streamline your time tracking effortlessly clock in and out, and manage your schedules and time sheets with ease.',
                    id: 2),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                customText(
                    weight: FontWeight.bold,
                    align: TextAlign.center,
                    textSize: 17,
                    text:
                        'Simplify your support needs management. Access the tools you need to ensure your work-life balance in the healthcare field.',
                    id: 2),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Column(
              children: <Widget>[
                SizedBox(
                  height: 480,
                ),
                customText(
                    weight: FontWeight.bold,
                    textSize: 17,
                    align: TextAlign.center,
                    text:
                        "C4CARE is your complete work-life solution in healthcare. Let's get started!",
                    id: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
