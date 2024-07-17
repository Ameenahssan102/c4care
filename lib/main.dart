// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:C4CARE/Navigation/nav.dart';
import 'package:C4CARE/Provider/attendance_provider.dart';
import 'package:C4CARE/Provider/login.provider.dart';
import 'package:C4CARE/Provider/profile.provider.dart';
import 'package:C4CARE/Utils/notification_service.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:C4CARE/Views/splash.dart';
import 'package:C4CARE/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';
import 'locator.dart' as ltr;
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ltr.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  NotificationService().initNotification();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MultiProvider(providers: [
            ChangeNotifierProvider(create: (_) => ltr.loc<LoginUser>()),
            ChangeNotifierProvider(create: (_) => ltr.loc<ProfileProvider>()),
            ChangeNotifierProvider(
                create: (_) => ltr.loc<AttendanceProvider>()),
          ], child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        theme: ThemeData(primaryColor: AppColors.primaryDarkColor),
        navigatorKey: NavigationService.navigatorKey,
        title: 'C4CARE',
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}
