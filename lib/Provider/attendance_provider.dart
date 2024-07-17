import 'package:C4CARE/Model/notifications.model.dart';
import 'package:C4CARE/Navigation/nav.dart';
import 'package:C4CARE/Views/tab2/models/time_sheet.dart';
import 'package:C4CARE/Views/tab2/tab2.dart';
import 'package:C4CARE/repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Dio/api_response.dart';
import '../Model/attendance_res.dart';
import '../Model/common_res_model.dart';
import '../Utils/time_utils.dart';
import '../Values/dialogs.dart';
import '../values/values.dart';

class AttendanceProvider with ChangeNotifier {
  final Repo repo;
  final NavigationService ns;
  final SharedPreferences sharedPreferences;
  AttendanceProvider(
      {required this.repo, required this.ns, required this.sharedPreferences});

  bool isCheckIn = false;
  String? checkInTime;
  DateTime? checkinTimee;
  String? checkoutTime;
  DateTime? checkoutTimee;
  String monthlyShifts = "";
  String weeklyShifts = "";
  List<TimeSheet> timeSheet = [];
  List<Meeting> meetings = [];
  List<Notifications> notifications = [];
  String name = "";

  int _page = 0;
  late int totalPages;

  getNotifications(
      {required RefreshController refreshCntrlr,
      bool isRefresh = false}) async {
    if (isRefresh) {
      _page = 0;
    } else {
      if (_page >= totalPages) {
        refreshCntrlr.loadNoData();
        return false;
      }
    }
    ApiResponse? res =
        await repo.getData("${StringConst.getNotifications}?page=$_page");

    if (res.response?.data != null && res.response!.statusCode == 200) {
      final notificationModel = NotificationsModel.fromJson(res.response?.data);

      if (isRefresh) {
        notifications = notificationModel.notifications!;
      } else {
        notifications.addAll(notificationModel.notifications!);
      }
      _page++;
      totalPages = notificationModel.totalPages!;
      notifyListeners();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<void> getAttendanceStatus() async {
    ApiResponse res = await repo.getData(StringConst.getAttendanceStatus);
    if (res.response != null && res.response!.statusCode == 200) {
      AttendanceRes attendanceRes = AttendanceRes.fromJson(res.response!.data);
      checkInTime = attendanceRes.checkInTimeStr;
      checkinTimee = attendanceRes.checkInTime;
      checkoutTimee = attendanceRes.checkOutTime;
      checkoutTime = attendanceRes.checkOutTimeStr;
      isCheckIn = attendanceRes.isCheckIn ?? false;
      monthlyShifts = attendanceRes.monthlyShifts ?? "";
      weeklyShifts = attendanceRes.weeklyShifts ?? "";
      name = sharedPreferences.getString("name")!;
      notifyListeners();
    } else {
      Alerts.showError(res.error);
    }
  }

  Future<void> checkIn(String clientId, QRViewController controller, String lat,
      String long) async {
    Dialogs.showLoading();
    var data = {'clientId': clientId, 'lat': lat, 'lng': long};
    if (kDebugMode) {
      print(data);
    }
    ApiResponse res = await repo.postData(StringConst.checkIn, data: data);
    Navigator.pop(ns.getContext());
    if (res.response != null && res.response!.statusCode == 200) {
      CommonRes commonRes = CommonRes.fromJson(res.response!.data);
      Dialogs.showAlertDialog2(
          context: ns.getContext(),
          title: "Check In",
          subTitle: commonRes.message,
          yesClick: () {
            getAttendanceStatus();
            Navigator.pop(ns.getContext());
          });
    } else {
      controller.resumeCamera();
      Alerts.showError(res.error);
    }
  }

  Future<void> checkOut(String clientId, QRViewController controller,
      String lat, String long) async {
    Dialogs.showLoading();
    var data = {'clientId': clientId, 'lat': lat, 'lng': long};
    ApiResponse res = await repo.postData(StringConst.checkOut, data: data);
    Navigator.pop(ns.getContext());
    if (res.response != null && res.response!.statusCode == 200) {
      CommonRes commonRes = CommonRes.fromJson(res.response!.data);
      Dialogs.showAlertDialog2(
          context: ns.getContext(),
          title: "Check Out",
          subTitle: commonRes.message,
          yesClick: () {
            getAttendanceStatus();
            Navigator.pop(ns.getContext());
          });
    } else {
      controller.resumeCamera();
      Alerts.showError(res.error.toString());
    }
  }

  Future<void> getMonthlyAttendance(String month, String year) async {
    meetings = [];
    Dialogs.showLoading();
    ApiResponse res = await repo
        .getData("${StringConst.getMonthlyAttendance}?month=$month&year=$year");
    Navigator.pop(ns.getContext());
    if (res.response != null && res.response!.statusCode == 200) {
      timeSheet = List<TimeSheet>.from(
          res.response!.data.map((x) => TimeSheet.fromJson(x)));
      meetings = getDataSource(timeSheet);
      notifyListeners();
    } else {
      Alerts.showError(res.error);
    }
  }

  Future<void> getWeeklyAttendance(String startdate, String enddate) async {
    meetings = [];
    Dialogs.showLoading();
    ApiResponse res = await repo.getData(
        "${StringConst.getWeeklyAttendance}?startdate=$startdate&enddate=$enddate");
    Navigator.pop(ns.getContext());
    if (res.response != null && res.response!.statusCode == 200) {
      List<TimeSheet> timeSheet = List<TimeSheet>.from(
          res.response!.data.map((x) => TimeSheet.fromJson(x)));
      meetings = getDataSource(timeSheet);
      notifyListeners();
    } else {
      Alerts.showError(res.error);
    }
  }

  List<Meeting> getDataSource(List<TimeSheet> timeSheet) {
    final List<Meeting> meetings = <Meeting>[];
    for (var time in timeSheet) {
      final DateTime today = TimeUtils.sting2Date(time.checkInTime!);
      final DateTime startTime = DateTime(today.year, today.month, today.day);
      meetings.add(
          Meeting('', startTime, startTime, const Color(0xFF0F8644), true));
    }
    return meetings;
  }

  TimeSheet? getDetails(DateTime? date) {
    int d = TimeUtils.date2int(date!);

    int selectedTimeSheet = timeSheet.indexWhere((element) {
      DateTime dd = TimeUtils.sting2Date(element.checkInTime!);
      return TimeUtils.date2int(dd) == d;
    });
    if (selectedTimeSheet == -1) {
      return null;
    }
    return timeSheet[selectedTimeSheet];
  }
}
