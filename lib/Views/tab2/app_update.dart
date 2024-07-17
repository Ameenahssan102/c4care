import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../Custom/base_widget.dart';
import '../../../Custom/custom_text.dart';
import '../../../Values/values.dart';

class AppUpdate extends StatefulWidget {
  final String message;
  final bool isandroid;

  const AppUpdate({Key? key, required this.message, required this.isandroid})
      : super(key: key);

  @override
  State<AppUpdate> createState() => _AppUpdateState();
}

class _AppUpdateState extends State<AppUpdate> {
  String? appstoreUrl;
  String? playstoreUrl;
  @override
  void initState() {
    super.initState();
    getinfo();
  }

  getinfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    appstoreUrl = sharedPreferences.getString("appstoreUrl") ?? "";
    playstoreUrl = sharedPreferences.getString("playstoreUrl") ?? "";
  }

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
          Lottie.asset('assets/lottie/app_update.json',
              width: 250.0, repeat: true),
          const SizedBox(height: 24.0),
          Row(
            children: [
              Expanded(
                  child: customText(
                      text: widget.message,
                      id: 2,
                      textSize: 17,
                      align: TextAlign.center,
                      color: AppColors.hint.withOpacity(.4))),
            ],
          ),
          const SizedBox(height: 58.0),
          ElevatedButton(
              onPressed: () async {
                widget.isandroid == true
                    ? await canLaunchUrlString("$playstoreUrl")
                        ? launchUrlString("$playstoreUrl")
                        : launchUrlString("https://play.google.com/")
                    : await canLaunchUrlString("$appstoreUrl")
                        ? launchUrlString("$appstoreUrl")
                        : launchUrlString("https://www.apple.com/app-store/");
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
                  Icon(Iconsax.flash, color: AppColors.white),
                  SizedBox(
                    width: 10,
                  ),
                  customText(
                    text: "UPDATE",
                    id: 1,
                    color: AppColors.white,
                  ),
                ],
              ))
          // ButtonOutlined(
          //   title: "UPDATE",
          //   onPressed: () => {},
          // )
        ],
      ),
    ));
  }
}
