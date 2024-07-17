// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:C4CARE/Provider/profile.provider.dart';
import 'package:C4CARE/Values/dialogs.dart';
import 'package:C4CARE/Custom/ctext.dart';
import 'package:C4CARE/Custom/custom_text.dart';
import 'package:C4CARE/Provider/login.provider.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:C4CARE/Views/notification/notification_screen.dart';
import 'package:C4CARE/Views/qr/qr_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../Custom/slide_right_route.dart';
import '../../../Provider/attendance_provider.dart';
import '../../../Utils/time_utils.dart';

class Tab1 extends StatefulWidget {
  const Tab1({super.key});
  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  Future<void> fetchPosition(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(msg: 'Location permission is required.');
      }
    } else if (!serviceEnabled) {
      bool locationSettingsOpened = await Geolocator.openLocationSettings();
      if (!locationSettingsOpened) {
        Fluttertoast.showToast(msg: 'Failed to open location settings.');
      }
    } else {
      // Get the current position.
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Update the position provider.
      final positionProvider = Provider.of<LoginUser>(context, listen: false);
      positionProvider.currentposition = currentPosition;
    }
  }

  late FlipCardController _controller;
  @override
  void initState() {
    super.initState();
    _controller = FlipCardController();
    Future.delayed(Duration.zero, () {
      Provider.of<LoginUser>(context, listen: false).getVersion();
      Provider.of<ProfileProvider>(context, listen: false).getProData();
      Provider.of<AttendanceProvider>(context, listen: false)
          .getAttendanceStatus();
    });
    fetchPosition(context);
    weekday(DateTime.now());
  }

  void doStuff() {
    // Flip the card a bit and back to indicate that it can be flipped (for example on page load)
    _controller.hint(
      duration: Duration(seconds: 1),
      total: Duration(seconds: 3),
    );

    // Tilt the card a bit (for example when hovering)
    _controller.hint(
      duration: Duration(seconds: 1),
      total: Duration(seconds: 3),
    );

    // Flip the card programmatically
    _controller.toggleCard();
  }

  String clockInTime = '';
  String clockOutTime = '';
  var startday;
  var endday;
  void weekday(DateTime currentDate) {
    var currentWeekday = currentDate.weekday;
    var offset = currentWeekday - DateTime.sunday;
    if (offset < 0) {
      offset = 7 + offset;
    }
    var sunday = currentDate.subtract(Duration(days: offset));
    var saturday = sunday.add(Duration(days: 6));
    startday = DateFormat('dd MMMM').format(sunday);
    endday = DateFormat('dd MMMM').format(saturday);
    if (kDebugMode) {
      print('Start of the week: $startday' + ', End of the week: $endday');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(child: Consumer<AttendanceProvider>(
        builder: (context, attendanceProvider, child) {
      LoginUser authProvider = Provider.of<LoginUser>(context, listen: false);
      ProfileProvider profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);

      return Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      AppColors.white,
                      AppColors.primaryColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: Stack(
                children: [
                  Column(children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Align(
                              alignment: AlignmentDirectional(0.00, -1.00),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  height: 50.0,
                                  fit: BoxFit.fitHeight,
                                  alignment: Alignment(0.00, 0.00),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "C4CARE",
                              style: GoogleFonts.lato(
                                color: AppColors.dark,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  SlideRightRoute(
                                      page: const NotificationScreen())),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColors.white,
                                child: CircleAvatar(
                                    radius: 27,
                                    backgroundColor: AppColors.primaryDarkColor,
                                    child: Icon(Iconsax.notification)),
                              ),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () async {
                                Dialogs.showAlertDialog(
                                    context: context,
                                    title: "Contact Help Center?",
                                    subTitle:
                                        "Would you like to send a message to our support team?",
                                    yesClick: () async => await canLaunchUrlString(
                                            "https://wa.me/${authProvider.versionModel?.contactNo}")
                                        ? launchUrlString(
                                            "https://wa.me/${authProvider.versionModel?.contactNo}")
                                        : launchUrlString(
                                            "tel:${authProvider.versionModel?.contactNo}"));
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColors.white,
                                child: CircleAvatar(
                                    radius: 27,
                                    backgroundColor: AppColors.primaryDarkColor,
                                    child: Icon(Icons.help_outline)),
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlipCard(
                            fill: Fill.fillBack,
                            direction: FlipDirection.HORIZONTAL,
                            side: CardSide.FRONT,
                            controller: _controller,
                            front: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 3,
                              shadowColor: AppColors.hint,
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 183, 238, 252),
                                        AppColors.primaryColor,
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp,
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                                height: size.height * .24,
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: AppColors
                                                      .white
                                                      .withOpacity(.7),
                                                  child: CircleAvatar(
                                                    radius: 27,
                                                    backgroundColor: AppColors
                                                        .hint
                                                        .withOpacity(.015),
                                                    child: profileProvider
                                                                .profileModel
                                                                ?.imageUrl !=
                                                            null
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            child:
                                                                Image.network(
                                                              profileProvider
                                                                  .profileModel!
                                                                  .imageUrl!,
                                                              width: 50,
                                                              height: 50,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          )
                                                        : Image.asset(
                                                            'assets/images/noimage.png',
                                                            width: 35,
                                                            height: 35,
                                                          ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Good Day 👋",
                                                      style: GoogleFonts.lato(
                                                        color: AppColors.dark
                                                            .withOpacity(.7),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        AutoSizeText(
                                                          attendanceProvider
                                                              .name
                                                              .replaceAll(
                                                                  ',', ''),
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            color: AppColors
                                                                .primaryDarkColor
                                                                .withOpacity(
                                                                    .6),
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          minFontSize: 17,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(children: [
                                              Expanded(
                                                child: Container(
                                                  color: AppColors.dark,
                                                  height: 1.0,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: AppColors
                                                      .primaryDarkColor,
                                                ),
                                                child: customText(
                                                    text: DateFormat('MMMM yyy')
                                                        .format(DateTime.now()),
                                                    id: 1,
                                                    textSize: 19,
                                                    color: AppColors.white),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                color:
                                                    AppColors.primaryDarkColor,
                                                width: 10,
                                                height: 33,
                                              ),
                                            ]),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CText(
                                                            text:
                                                                "Monthly Shifts   ",
                                                            textcolor: AppColors
                                                                .dark
                                                                .withOpacity(
                                                                    .6),
                                                            size: 17,
                                                            fontw:
                                                                FontWeight.w600,
                                                          ),
                                                          SizedBox(
                                                            width: 3,
                                                          ),
                                                          Text(
                                                            attendanceProvider
                                                                .monthlyShifts,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              color: AppColors
                                                                  .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 35,
                                                              shadows: [
                                                                BoxShadow(
                                                                    color: AppColors
                                                                        .dark
                                                                        .withOpacity(
                                                                            0.6),
                                                                    offset:
                                                                        const Offset(
                                                                            0, 3),
                                                                    blurRadius:
                                                                        2,
                                                                    spreadRadius:
                                                                        0.4)
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ]))
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            back: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 3,
                              shadowColor: AppColors.hint,
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 183, 238, 252),
                                        AppColors.primaryDarkColor,
                                      ],
                                      begin: const FractionalOffset(0.0, 0.0),
                                      end: const FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp,
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                                height: size.height * .24,
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: AppColors
                                                      .white
                                                      .withOpacity(.7),
                                                  child: CircleAvatar(
                                                    radius: 27,
                                                    backgroundColor: AppColors
                                                        .hint
                                                        .withOpacity(.015),
                                                    child: profileProvider
                                                                .profileModel
                                                                ?.imageUrl !=
                                                            null
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            child:
                                                                Image.network(
                                                              profileProvider
                                                                  .profileModel!
                                                                  .imageUrl!,
                                                              width: 50,
                                                              height: 50,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          )
                                                        : Image.asset(
                                                            'assets/images/noimage.png',
                                                            width: 35,
                                                            height: 35,
                                                          ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Good Day 👋",
                                                      style: GoogleFonts.lato(
                                                        color: AppColors.dark
                                                            .withOpacity(.7),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        AutoSizeText(
                                                          attendanceProvider
                                                              .name
                                                              .replaceAll(
                                                                  ',', ''),
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            color: AppColors
                                                                .primaryDarkColor
                                                                .withOpacity(
                                                                    .6),
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          minFontSize: 17,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(children: [
                                              Expanded(
                                                child: Container(
                                                  color: AppColors.dark,
                                                  height: 1.0,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: AppColors
                                                      .primaryDarkColor,
                                                ),
                                                child: customText(
                                                    text: (startday != null &&
                                                            endday != null)
                                                        ? '$startday - $endday'
                                                        : DateFormat('MMMM yyy')
                                                            .format(
                                                                DateTime.now()),
                                                    id: 1,
                                                    textSize: 19,
                                                    color: AppColors.white),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                color:
                                                    AppColors.primaryDarkColor,
                                                width: 10,
                                                height: 33,
                                              ),
                                            ]),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CText(
                                                            text:
                                                                "Weekly Shifts   ",
                                                            textcolor: AppColors
                                                                .dark
                                                                .withOpacity(
                                                                    .6),
                                                            size: 17,
                                                            fontw:
                                                                FontWeight.w600,
                                                          ),
                                                          SizedBox(
                                                            width: 3,
                                                          ),
                                                          Text(
                                                            attendanceProvider
                                                                .weeklyShifts,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              color: AppColors
                                                                  .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 35,
                                                              shadows: [
                                                                BoxShadow(
                                                                    color: AppColors
                                                                        .dark
                                                                        .withOpacity(
                                                                            0.6),
                                                                    offset:
                                                                        const Offset(
                                                                            0, 3),
                                                                    blurRadius:
                                                                        2,
                                                                    spreadRadius:
                                                                        0.4)
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ]))
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      margin: EdgeInsets.zero,
                      borderOnForeground: false,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: SingleChildScrollView(
                            child: Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CText(
                                    text: "Time Clock",
                                    textcolor: AppColors.primaryDarkColor,
                                    size: Sizes.TEXT_SIZE_24,
                                    fontw: FontWeight.bold,
                                  ),
                                ],
                              ),
                              Divider(
                                height: 10,
                                color: AppColors.dark,
                                thickness: .06,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.white10),
                                margin: const EdgeInsets.all(10.0),
                                padding: const EdgeInsets.all(16.0),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    Row(children: [
                                      Expanded(
                                        child: Container(
                                          color: AppColors.primaryDarkColor
                                              .withOpacity(.15),
                                          height: 1.0,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      if (attendanceProvider.checkinTimee !=
                                          null)
                                        customText(
                                            text: attendanceProvider
                                                        .checkinTimee !=
                                                    null
                                                ? DateFormat.yMEd().format(
                                                    attendanceProvider
                                                        .checkinTimee!)
                                                : "-",
                                            color:
                                                AppColors.hint.withOpacity(.5),
                                            id: 1),
                                    ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CText(
                                            text: "Clocked In ",
                                            textcolor:
                                                AppColors.primaryDarkColor,
                                            size: Sizes.TEXT_SIZE_24,
                                            fontw: FontWeight.bold,
                                          ),
                                          CText(
                                            text: attendanceProvider
                                                        .checkInTime !=
                                                    null
                                                ? attendanceProvider
                                                    .checkInTime!
                                                    .substring(11, 16)
                                                : "-",
                                            textcolor:
                                                AppColors.black.withOpacity(.6),
                                            size: Sizes.TEXT_SIZE_24,
                                            fontw: FontWeight.bold,
                                          ),
                                        ]),
                                    // Divider(
                                    //   height: 10,
                                    //   color: AppColors.dark,
                                    //   thickness: .06,
                                    // ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            color: AppColors.primaryDarkColor
                                                .withOpacity(.16),
                                            height: 1.0,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        if (attendanceProvider.checkoutTimee !=
                                            null)
                                          customText(
                                              text: attendanceProvider
                                                          .checkoutTimee !=
                                                      null
                                                  ? DateFormat.yMEd().format(
                                                      attendanceProvider
                                                          .checkoutTimee!)
                                                  : "-",
                                              color: AppColors.hint
                                                  .withOpacity(.5),
                                              id: 1),
                                      ],
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CText(
                                            text: "Clocked Out",
                                            textcolor:
                                                AppColors.primaryDarkColor,
                                            size: Sizes.TEXT_SIZE_24,
                                            fontw: FontWeight.bold,
                                          ),
                                          CText(
                                            text: attendanceProvider
                                                        .checkoutTime !=
                                                    null
                                                ? attendanceProvider
                                                    .checkoutTime!
                                                    .substring(11, 16)
                                                : "-",
                                            textcolor:
                                                AppColors.black.withOpacity(.6),
                                            size: Sizes.TEXT_SIZE_24,
                                            fontw: FontWeight.bold,
                                          ),
                                        ]),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primaryColor.withOpacity(.07),
                                      AppColors.primaryDarkColor
                                          .withOpacity(.07)
                                    ],
                                    stops: [0.0, 0.0],
                                    tileMode: TileMode.clamp,
                                  ),
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            formatTime(clockInTime),
                                            style: GoogleFonts.lato(
                                              color: AppColors.dark
                                                  .withOpacity(.4),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                backgroundColor:
                                                    attendanceProvider
                                                                .isCheckIn ==
                                                            false
                                                        ? AppColors.blue
                                                        : AppColors.blue
                                                            .withOpacity(.7),
                                                fixedSize: Size(
                                                    size.width * 0.45, 100),
                                              ),
                                              onPressed: () async {
                                                if (attendanceProvider
                                                        .isCheckIn ==
                                                    false) {
                                                  bool serviceEnabled =
                                                      await Geolocator
                                                          .isLocationServiceEnabled();
                                                  if (serviceEnabled) {
                                                    Navigator.push(
                                                        context,
                                                        SlideRightRoute(
                                                            page: QrScreen(
                                                                action:
                                                                    'checkIn')));
                                                  } else {
                                                    fetchPosition(context);
                                                  }
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "You are already checked In");
                                                }
                                              },
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    if (attendanceProvider
                                                            .isCheckIn ==
                                                        false)
                                                      Icon(Iconsax.arrow_up_14,
                                                          color: AppColors
                                                              .white10),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    customText(
                                                      text: attendanceProvider
                                                                  .isCheckIn ==
                                                              false
                                                          ? 'Clock In'
                                                          : 'Clocked In',
                                                      id: 1,
                                                      color: AppColors.black,
                                                      textSize: 20,
                                                    ),
                                                  ])),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            formatTime(clockOutTime),
                                            style: GoogleFonts.lato(
                                              color: AppColors.dark
                                                  .withOpacity(.4),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                backgroundColor: AppColors.blue,
                                                fixedSize: Size(
                                                    size.width * 0.45, 100),
                                              ),
                                              onPressed: () async {
                                                if (attendanceProvider
                                                        .isCheckIn ==
                                                    true) {
                                                  bool serviceEnabled =
                                                      await Geolocator
                                                          .isLocationServiceEnabled();
                                                  if (serviceEnabled) {
                                                    Navigator.push(
                                                        context,
                                                        SlideRightRoute(
                                                            page: QrScreen(
                                                                action:
                                                                    'checkOut')));
                                                  } else {
                                                    fetchPosition(context);
                                                  }
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Please Clock in before Clock out");
                                                }
                                              },
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Iconsax.arrow_down_24,
                                                        color: AppColors.white),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    customText(
                                                      text: 'Clock Out',
                                                      id: 1,
                                                      color: AppColors.black,
                                                      textSize: 20,
                                                    ),
                                                  ])),
                                        ],
                                      ),
                                    ]),
                              ),
                            ]),
                          )),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      );
    }));
  }

  // Function to format the time
  String formatTime(String time) {
    if (time.isEmpty) {
      return ''; // Return an empty string if no time is set
    }
    // Format the time as "HH:mm"
    final formattedTime = DateFormat('HH:mm').format(DateTime.parse(time));
    return formattedTime;
  }
}
