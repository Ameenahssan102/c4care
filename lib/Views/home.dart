// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, non_constant_identifier_names

import 'package:C4CARE/Utils/messaging_service.dart';
import 'package:C4CARE/Values/dialogs.dart';
import 'package:C4CARE/Views/tab1/tab1.dart';
import 'package:C4CARE/Views/tab2/tab2.dart';
import 'package:C4CARE/Views/tab3/tab3.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> pages = [
    const Tab1(key: PageStorageKey('Page1')),
    const Tab2(key: PageStorageKey('Page2')),
    const ProfileScreen(key: PageStorageKey('Page3')),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  int _selectedIndex = 0;
  DateTime pre_backpress = DateTime.now();
  int visit = 0;

  @override
  void initState() {
    super.initState();
    MessagingService(context: context).init();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) {
          return true;
        } else {
          setState(() => _selectedIndex = 0);
          return false;
        }
      },
      child: Scaffold(
        body: PageStorage(bucket: bucket, child: pages[_selectedIndex]),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: BottomBarDefault(
                borderRadius: BorderRadius.circular(8),
                top: 15,
                enableShadow: true,
                bottom: 15,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.primaryColor.withOpacity(.7),
                      blurRadius: 5)
                ],
                items: items,
                backgroundColor: AppColors.primaryDarkColor,
                color: AppColors.black,
                colorSelected: Colors.white,
                titleStyle: TextStyle(color: AppColors.white, fontSize: 5),
                indexSelected: _selectedIndex,
                paddingVertical: 22,
                onTap: (int index) => setState(() => _selectedIndex = index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Bottom Navigation Bar ----
  List<TabItem> items = [
    TabItem(icon: Iconsax.home),
    TabItem(
      icon: Iconsax.calendar,
    ),
    TabItem(icon: Iconsax.user)
  ];
}
