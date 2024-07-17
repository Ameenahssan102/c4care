import 'package:C4CARE/Views/notification/notification_screen.dart';
import 'package:C4CARE/Views/tab2/models/time_sheet.dart';

import '../Custom/ctext.dart';
import '../Custom/texts.dart';
import '../Navigation/nav.dart';
import '../values/values.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

class Dialogs {
  static showLoading() {
    showDialog(
      barrierColor: Colors.black38,
      barrierDismissible: false,
      context: GetIt.I<NavigationService>().getContext(),
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                Center(
                    child: Container(
                  decoration: Decorations.boxDecorationColorBorder(
                      color: Colors.white, borderRadius: 4.0),
                  height: 40.0,
                  width: 96.0,
                )),
                Center(
                    child: Lottie.asset(
                  'assets/lottie/loading.json',
                  width: 96.0,
                  fit: BoxFit.fitWidth,
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  static showLoading2(BuildContext context) {
    showDialog(
      barrierColor: Colors.black38,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                Center(
                    child: Container(
                  decoration: Decorations.boxDecorationColorBorder(
                      color: Colors.white, borderRadius: 4.0),
                  height: 40.0,
                  width: 96.0,
                )),
                Center(
                    child: Lottie.asset(
                  'assets/lottie/loading.json',
                  width: 96.0,
                  fit: BoxFit.fitWidth,
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  static showAlertDialog(
      {required BuildContext context,
      required String title,
      String? subTitle,
      required VoidCallback yesClick}) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CText(
              text: title,
              textcolor: AppColors.primaryDarkColor,
              fontw: FontWeight.bold,
              size: 19,
            ),
            Divider(
              height: 2,
              color: AppColors.primaryDarkColor,
            ),
          ],
        ),
        content: CText(
          text: subTitle ?? "",
          textcolor: AppColors.hint,
          fontw: FontWeight.w600,
          size: 16,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("NO")),
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
                yesClick();
              },
              child: const Text("YES")),
        ],
      ),
    );
  }

  static showAlertDialog3(
      {required BuildContext context,
      required String title,
      String? subTitle,
      required VoidCallback yesClick}) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext contxt2) => AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 18.0,
                  fit: BoxFit.fitHeight,
                  alignment: const Alignment(0.00, 0.00),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: CText(
                    maxlines: 1,
                    text: title,
                    textcolor: AppColors.primaryDarkColor,
                    fontw: FontWeight.bold,
                    size: 19,
                  ),
                ),
              ],
            ),
            Divider(
              color: AppColors.primaryDarkColor,
            ),
          ],
        ),
        content: Texts.regular(subTitle),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(contxt2, true);
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                Navigator.pop(contxt2, true);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              },
              child: const Text("Open")),
        ],
      ),
    );
  }

  static showAlertDialog2(
      {required BuildContext context,
      required String title,
      String? subTitle,
      required VoidCallback yesClick}) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CText(
              text: title,
              textcolor: AppColors.primaryDarkColor,
              fontw: FontWeight.bold,
              size: 19,
            ),
            Divider(
              height: 2,
              color: AppColors.primaryDarkColor,
            ),
          ],
        ),
        content: Texts.regular(subTitle),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
                yesClick();
              },
              child: const Text("YES")),
        ],
      ),
    );
  }

  static showAttendance(
      {required BuildContext context, required TimeSheet timeSheet}) async {
    showDialog(
      barrierColor: Colors.black38,
      barrierDismissible: true,
      context: GetIt.I<NavigationService>().getContext(),
      builder: (context) {
        return Dialog(
          elevation: 0.0,
          backgroundColor: Colors.white,
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Texts.regular(timeSheet.client?.name ?? "",
                              color: AppColors.primaryDarkColor)),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(flex: 2, child: Texts.regular("Check In")),
                      Texts.mediumText(":"),
                      const SizedBox(width: 16.0),
                      Expanded(
                          flex: 3, child: Texts.regular(timeSheet.checkInTime)),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(flex: 2, child: Texts.regular("Check Out")),
                      Texts.mediumText(":"),
                      const SizedBox(width: 16.0),
                      Expanded(
                          flex: 3,
                          child:
                              Texts.regular(timeSheet.checkOutTime ?? 'N/A')),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
