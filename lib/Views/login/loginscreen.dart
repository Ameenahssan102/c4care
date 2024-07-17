// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, constant_identifier_names, avoid_print

import 'dart:async';

import 'package:C4CARE/Custom/custom_text.dart';
import 'package:C4CARE/Custom/custom_textfield.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../Provider/login.provider.dart';

class LoginScreen extends StatefulWidget {
  final SharedPreferences? sharedPreferences;
  // final Version? version;

  const LoginScreen({
    Key? key,
    this.sharedPreferences,
    // this.version,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool visible = true;
  static const _timerDuration = 20;
  final StreamController _timerStream = StreamController<int>();
  int? timerCounter;
  Timer? _resendCodeTimer;

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    _timerStream.close();
    _resendCodeTimer?.cancel();

    super.dispose();
  }

  bool buttonEnabled = true;

  activeCounter() {
    buttonEnabled = false;
    _resendCodeTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_timerDuration - timer.tick > 0) {
        _timerStream.sink.add(_timerDuration - timer.tick);
      } else {
        _timerStream.sink.add(0);
        buttonEnabled = true;
        _resendCodeTimer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Consumer<LoginUser>(builder: (context, authProvider, child) {
          return Form(
              key: _formKey,
              child: Stack(children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(children: [
                      SizedBox(height: size.height * 0.14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/logo3.png',
                              width: size.width / 2,
                              height: 130.0,
                              fit: BoxFit.fitHeight,
                              alignment: Alignment(0.00, 0.00),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: size.width,
                        height: 330,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: AppColors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: CustomTextFormField(
                                        // validator: (value) {
                                        //   if (value!.isEmpty) {
                                        //     return "UserName can't be empty";
                                        //   } else if (value.length < 5) {
                                        //     return "Invalid UserName";
                                        //   }
                                        //   return null;
                                        // },
                                        controller:
                                            authProvider.emailController,
                                        hint: "Email",
                                      ),
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: CustomTextFormField(
                                        obscureText: visible,
                                        suffixIcon: InkWell(
                                            onTap: () {
                                              setState(() {
                                                visible = !visible;
                                              });
                                            },
                                            child: Icon(
                                              visible == false
                                                  ? Iconsax.eye
                                                  : Iconsax.eye_slash,
                                              color: AppColors.hint
                                                  .withOpacity(.4),
                                            )),
                                        // validator: (value) {
                                        //   if (value!.isEmpty) {
                                        //     return "Password can't be empty";
                                        //   } else if (value.length < 5) {
                                        //     return "Invalid Password";
                                        //   }
                                        //   return null;
                                        // },
                                        controller:
                                            authProvider.passwordController,
                                        hint: "Password",
                                      ),
                                    ),
                                  ),
                                ]),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            color: AppColors.black
                                                .withOpacity(0.6)),
                                        text:
                                            "By logging in ,you are agreeing to C4CARE App's"),
                                  ])),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: AppColors.primaryDarkColor),
                                      text: "Terms and Conditions",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          const Terms =
                                              "https://care4consulting.co.uk/terms_and_conditions.html";
                                          await canLaunchUrlString(Terms)
                                              ? launchUrlString(Terms)
                                              : print(
                                                  "error while opening Terms &Conditions");
                                        }),
                                  TextSpan(
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          color:
                                              AppColors.black.withOpacity(0.6)),
                                      text: " and "),
                                  TextSpan(
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: AppColors.primaryDarkColor),
                                      text: "Privacy Policy",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          const Policy =
                                              "https://care4consulting.co.uk/privacy_policy.html";
                                          await canLaunchUrlString(Policy)
                                              ? launchUrlString(Policy)
                                              : print(
                                                  "error while opening Policy");
                                        }),
                                ])),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  authProvider.login();
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    fixedSize: Size(size.width, 60),
                                    backgroundColor: AppColors.primaryDarkColor,
                                    textStyle: GoogleFonts.lato(fontSize: 20)),
                                child: Row(
                                  children: [
                                    Icon(Iconsax.login, color: AppColors.white),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    customText(
                                      text: "Login",
                                      id: 1,
                                      color: AppColors.white,
                                    ),
                                  ],
                                )

                                // auth.load == false
                                //     ?
                                //     : SizedBox(
                                //         width: 35,
                                //         height: 35,
                                //         child: SpinKitPulse(
                                //           color: AppColors.white,
                                //           duration: Duration(seconds: 2),
                                //         ),
                                ),
                          ],
                        ),
                      ),
                      // ElevatedButton(onPressed: ()=>Timer(
                      //                 Duration(milliseconds: 800),
                      //                 () => Navigator.pushAndRemoveUntil(
                      //                     context,
                      //                     MaterialPageRoute(
                      //                         builder: (context) =>
                      //                              HomePage(id: 2,)),
                      //                     (route) => false)), child: customText(text: "support", id: 1)),

                      // InkWell(
                      //   onTap: () => authProvider.forgetPassword(),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       customText(
                      //         text: "Forgot Password?",
                      //         id: 2,
                      //         color: AppColors.hint,
                      //         weight: FontWeight.w600,
                      //         textSize: 16,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      StreamBuilder<dynamic>(
                        stream: _timerStream.stream,
                        initialData: 0,
                        builder: (BuildContext ctx,
                            AsyncSnapshot<dynamic> snapshot) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: buttonEnabled
                                    ? () {
                                        if (authProvider
                                            .emailController.text.isEmpty) {
                                          Alerts.showError(
                                              "Email is not allowed to be empty !");
                                        } else {
                                          authProvider.forgetPassword();
                                          activeCounter();
                                        }
                                      }
                                    : null,
                                child: Row(
                                  // mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    snapshot.data == 0
                                        ? Text(
                                            "Forgot Password?",
                                            style: TextStyle(
                                              color: Colors
                                                  .blue, // Add your desired text style
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          )
                                        : customText(
                                            color:
                                                AppColors.hint.withOpacity(.6),
                                            id: 1,
                                            text:
                                                'Retry after ${snapshot.data}s'),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     if (buttonEnabled) {

                      //     }
                      //   },
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       Text(
                      //         "Forgot Password?",
                      //         style: TextStyle(
                      //           color:
                      //               Colors.blue, // Add your desired text style
                      //           fontWeight: FontWeight.w600,
                      //           fontSize: 16,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ]),
                  ),
                ),
              ]));
        }));
  }
}
