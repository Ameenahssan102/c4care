// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api


import 'package:after_layout/after_layout.dart';
import 'package:C4CARE/Provider/login.provider.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({
    Key? key,
  }) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with AfterLayoutMixin {
  @override
  void initState() {
    super.initState();
    afterFirstLayout(context);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    LoginUser authProvider = Provider.of<LoginUser>(context, listen: false);
    authProvider.checkVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(
          children: [
            Center(
                child: Image.asset(
              'assets/images/logo3.png',
              width: MediaQuery.of(context).size.width / 2,
              height: 250.0,
            )),
          ],
        ));
  }
}
