// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:C4CARE/Dio/api_response.dart';
import 'package:C4CARE/Dio/dio_client.dart';
import 'package:C4CARE/Values/dialogs.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:C4CARE/Views/login/loginscreen.dart';
import 'package:C4CARE/Views/home.dart';
import 'package:C4CARE/Views/noInternetScreen.dart';
import 'package:C4CARE/Views/onboarding/onboarding_screen.dart';
import 'package:C4CARE/Views/tab2/app_update.dart';
import 'package:C4CARE/Views/tab2/maintenance.dart';
import 'package:C4CARE/repo.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../Custom/slide_right_route.dart';
import '../Model/common_res_model.dart';
import '../Model/versionmodel.dart';
import '../Navigation/nav.dart';
import '../Views/login/models/login_model.dart';

class LoginUser with ChangeNotifier {
  final Repo repo;
  final DioClient dioClient;
  final NavigationService ns;
  final SharedPreferences sharedPreferences;
  LoginUser(
      {required this.repo,
      required this.ns,
      required this.dioClient,
      required this.sharedPreferences});

  final firebaseMessaging = FirebaseMessaging.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  CalendarView calendarView = CalendarView.week;

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Position? _currentposition;
  Position? get currentposition => _currentposition;
  set currentposition(Position? position) {
    _currentposition = position;
    notifyListeners();
  }

  VersionModel? versionModel;
  Future<void> getVersion() async {
    ApiResponse res = await repo.getData(StringConst.getVersion);
    if (res.response != null && res.response!.statusCode == 200) {
      versionModel = VersionModel.fromJson(res.response!.data);
      notifyListeners();
    } else {
      Alerts.showError(res.error);
    }
  }

  Future<void> checkVersion() async {
    var connection = await Connectivity().checkConnectivity();
    if (connection != ConnectivityResult.none) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String buildNumber = packageInfo.buildNumber;
      ApiResponse res = await repo.getData(StringConst.getVersion);
      if (res.response != null && res.response!.statusCode == 200) {
        VersionModel versionModel = VersionModel.fromJson(res.response!.data);
        sharedPreferences.setString("playstoreUrl", versionModel.playstoreUrl!);
        sharedPreferences.setString("appstoreUrl", versionModel.appstoreUrl!);
        if (Platform.isAndroid) {
          androidGoto(buildNumber, versionModel);
        } else if (Platform.isIOS) {
          iosGoto(buildNumber, versionModel);
        }
      } else {
        Alerts.showError(res.error);
      }
    } else {
      Navigator.push(ns.getContext(),
          MaterialPageRoute(builder: (context) => const NoInternetScreen()));
    }
  }

  void iosGoto(String buildNumber, VersionModel version) {
    if (version.iosServerDown!) {
      Navigator.pushAndRemoveUntil(
          ns.getContext(),
          SlideRightRoute(
              page: AppMaintenance(
                  message:
                      "We're currently performing scheduled maintenance to improve your experience. We'll be back shortly.")),
          (route) => false);
    } else if (int.parse(buildNumber) >= version.iosSupportingVersion!) {
      goto();
    } else {
      Navigator.pushAndRemoveUntil(
          ns.getContext(),
          SlideRightRoute(
              page: AppUpdate(
                  message:
                      "A new version of App is now available for download. To continue using the app and enjoy the latest features and improvements, please update it now.",
                  isandroid: false)),
          (route) => false);
    }
  }

  void androidGoto(String buildNumber, VersionModel version) {
    if (version.androidServerDown!) {
      Navigator.pushAndRemoveUntil(
          ns.getContext(),
          SlideRightRoute(
              page: AppMaintenance(
                  message:
                      "We're currently performing scheduled maintenance to improve your experience. We'll be back shortly.")),
          (route) => false);
    } else if (int.parse(buildNumber) >= version.androidSupportingVersion!) {
      goto();
    } else {
      Navigator.pushAndRemoveUntil(
          ns.getContext(),
          SlideRightRoute(
              page: AppUpdate(
            message:
                "A new version of App is now available for download. To continue using the app and\nenjoy the latest features and improvements, please update it now.",
            isandroid: true,
          )),
          (route) => false);
    }
  }

  void goto() {
    bool isLoggedIn = sharedPreferences.getBool('isLogged') ?? false;
    bool seenOnboarding = sharedPreferences.getBool('seenOnboarding') ?? false;
    if (isLoggedIn) {
      Navigator.pushAndRemoveUntil(
          ns.getContext(),
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    } else {
      if (seenOnboarding == true) {
        Navigator.pushAndRemoveUntil(
            ns.getContext(),
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            ns.getContext(),
            MaterialPageRoute(builder: (context) => const Onboarding()),
            (route) => false);
      }
    }
  }

  Future<void> login() async {
    String email = emailController.text;
    String password = passwordController.text;
    var fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      // print("fcm-$fcmToken");
      if (email.isEmpty && password.isEmpty) {
        Alerts.showError("Login credentials are empty");
      } else if (email.isEmpty) {
        Alerts.showError("Email is is not allowed to be empty!");
      } else if (password.isEmpty) {
        Alerts.showError("Password is is not allowed to be empty!");
      } else {
        Dialogs.showLoading();
        ApiResponse res = await repo.postData(StringConst.login,
            data: {'email': email, 'password': password, 'fcmToken': fcmToken});
        Navigator.pop(ns.getContext());
        if (res.response != null && res.response!.statusCode == 200) {
          clearControllers();
          LoginResModel loginRes = LoginResModel.fromJson(res.response!.data);
          dioClient.dio.options.headers = {'Authorization': loginRes.jwtToken};
          sharedPreferences.setString("name", loginRes.name);
          sharedPreferences.setString("email", loginRes.email);
          sharedPreferences.setString("mobile", loginRes.mobile);
          if (kDebugMode) {
            print(loginRes.jwtToken);
          }
          sharedPreferences.setString("token", loginRes.jwtToken);
          sharedPreferences.setBool("isLogged", true);
          Navigator.pushAndRemoveUntil(
              ns.getContext(),
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        } else {
          Alerts.showError(res.error);
        }
      }
    } else {
      Alerts.showError("Notification Service Unavailable");
    }
  }

  Future<void> forgetPassword() async {
    String email = emailController.text;
    ApiResponse res;
    Dialogs.showLoading();
    res =
        await repo.postData(StringConst.forgetPassword, data: {'email': email});
    Navigator.pop(ns.getContext());
    if (res.response != null && res.response!.statusCode == 200) {
      CommonRes commonRes = CommonRes.fromJson(res.response!.data);
      Alerts.showSuccess(commonRes.message);
    } else {
      Alerts.showError(res.error);
    }
  }

  Future<void> updatePassword() async {
    String currentPassword = currentPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;
    if (newPassword.length < 8) {
      Alerts.showError("New password must be at least 8 characters long");
    } else if (newPassword != confirmPassword) {
      Alerts.showError("Enter valid password");
    } else {
      var data = {
        'currentPassword': currentPassword,
        'newPassword': confirmPassword
      };
      ApiResponse res =
          await repo.postData(StringConst.updatePassword, data: data);
      if (res.response != null && res.response!.statusCode == 200) {
        CommonRes commonRes = CommonRes.fromJson(res.response!.data);
        Alerts.showSuccess(commonRes.message);
        logout();
      } else {
        clearControllers();
        Alerts.showError(res.error);
      }
    }
  }

  logout() {
    clearControllers();
    sharedPreferences.clear();
    Navigator.pushAndRemoveUntil(ns.getContext(),
        SlideRightRoute(page: const LoginScreen()), (route) => false);
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }
}
