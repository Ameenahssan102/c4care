// ignore_for_file: unnecessary_null_comparison, prefer_is_empty

import 'package:C4CARE/Custom/ctext.dart';
import 'package:C4CARE/Custom/custom_text.dart';
import 'package:C4CARE/Custom/customfooter.dart';
import 'package:C4CARE/Custom/slide_right_route.dart';
import 'package:C4CARE/Provider/attendance_provider.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:C4CARE/Views/notification/notification_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../Custom/base_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final RefreshController refreshCntrlr =
      RefreshController(initialRefresh: true);
  @override
  void initState() {
    super.initState();
    Provider.of<AttendanceProvider>(context, listen: false)
        .getNotifications(refreshCntrlr: refreshCntrlr);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<AttendanceProvider>(
        builder: (context, provider, child) => BaseWidget(
            appBar: AppBar(
              elevation: 0,
              title: const customText(text: 'Notifications', id: 1),
              backgroundColor: AppColors.primaryDarkColor,
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(Iconsax.arrow_left_1),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                    child: SmartRefresher(
                  controller: refreshCntrlr,
                  enablePullUp: true,
                  enablePullDown: true,
                  footer: const CustomFooter2(),
                  onRefresh: () async {
                    final result = await provider.getNotifications(
                      isRefresh: true,
                      refreshCntrlr: refreshCntrlr,
                    );
                    if (result) {
                      refreshCntrlr.refreshCompleted();
                    } else {
                      refreshCntrlr.refreshFailed();
                    }
                  },
                  onLoading: () async {
                    final result2 = await provider.getNotifications(
                        refreshCntrlr: refreshCntrlr);
                    if (result2) {
                      refreshCntrlr.loadComplete();
                    } else {
                      refreshCntrlr.loadFailed();
                    }
                  },
                  child: provider.notifications == null
                      ? SizedBox(
                          height: size.height * 0.6,
                          child: Center(
                              child: SpinKitChasingDots(
                                  color: AppColors.primaryColor,
                                  size: 50.0,
                                  duration:
                                      const Duration(milliseconds: 1200))),
                        )
                      : provider.notifications.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Lottie.asset(
                                      'assets/lottie/nonotification.json',
                                      width: size.width - 80,
                                      repeat: true),
                                ),
                                const SizedBox(
                                  height: 90,
                                ),
                                const customText(
                                  text: "There are no messages to display !",
                                  id: 2,
                                  textSize: 17,
                                )
                              ],
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                var data = provider.notifications[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          SlideRightRoute(
                                              page: NotificationContent(
                                                  data: data)));
                                    },
                                    child: Stack(
                                      children: [
                                        Card(
                                          shadowColor:
                                              AppColors.primaryDarkColor,
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: ListTile(
                                              leading: CircleAvatar(
                                                  backgroundColor: AppColors
                                                      .primaryColor
                                                      .withOpacity(.3),
                                                  child: Icon(
                                                    Iconsax.message,
                                                    color: AppColors
                                                        .primaryDarkColor,
                                                  )),
                                              title: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: CText(
                                                          text: data.title!,
                                                          fontw:
                                                              FontWeight.bold,
                                                          size: 19,
                                                          maxlines: 1,
                                                          textcolor:
                                                              AppColors.dark,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    color: AppColors
                                                        .primaryColor
                                                        .withOpacity(.3),
                                                  )
                                                ],
                                              ),
                                              subtitle: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: CText(
                                                        text: data.content!,
                                                        maxlines: 2,
                                                      )),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: size.width / 3,
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          height: 2,
                                                          color: AppColors
                                                              .primaryColor
                                                              .withOpacity(.1),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  )
                                                ],
                                              )),
                                        ),
                                        Positioned.fill(
                                            bottom: 5,
                                            right: 10,
                                            child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: AppColors
                                                          .primaryDarkColor
                                                          .withOpacity(.1),
                                                      radius: 3,
                                                    ),
                                                    const SizedBox(
                                                      width: 3,
                                                    ),
                                                    CText(
                                                        size: 11,
                                                        textcolor: AppColors
                                                            .hint
                                                            .withOpacity(.7),
                                                        text: DateFormat(
                                                                'dd MMM , ha')
                                                            .format(data
                                                                .createdAt!)),
                                                  ],
                                                )))
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider();
                              },
                              itemCount: provider.notifications.length != 0
                                  ? provider.notifications.length
                                  : 0),
                ))
              ],
            )));
  }
}
