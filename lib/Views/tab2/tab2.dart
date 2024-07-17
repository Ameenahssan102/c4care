// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:C4CARE/Custom/ctext.dart';
import 'package:C4CARE/Values/values.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../Provider/attendance_provider.dart';
import '../../../Values/dialogs.dart';
import 'models/time_sheet.dart';

class Tab2 extends StatefulWidget {
  const Tab2({super.key});

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  CalendarView calendarView = CalendarView.month;
  String datechange = '';
  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);
  var startday;
  var startday2;
  var startday3;
  var startday4;
  String _month = "";
  String _year = "";
  var endday;
  var endday2;
  var endday3;
  var endday4;
  bool shiftvalue = true;

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
    startday4 = DateFormat("yyyy-MM-dd").format(sunday);
    endday4 = DateFormat("yyyy-MM-dd").format(saturday);
    if (kDebugMode) {
      print('Start of the week: $startday' + ', End of the week: $endday');
    }
  }

  @override
  void initState() {
    super.initState();
    weekday(DateTime.now());
    Future.delayed(Duration.zero, () {
      Provider.of<AttendanceProvider>(context, listen: false)
          .getAttendanceStatus();
      Provider.of<AttendanceProvider>(context, listen: false)
          .getMonthlyAttendance(
        DateFormat('MMMM').format(DateTime.now()),
        DateFormat('yyyy').format(DateTime.now()),
      )
          .then((value) {
        datechange = DateFormat('MMMM yyy').format(DateTime.now()).toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer<AttendanceProvider>(
        builder: (context, attendanceProvider, child) {
      return Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
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
                          "Timesheet",
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
                          onTap: () {
                            setState(() {
                              if (calendarView == CalendarView.month) {
                                startday2 != null
                                    ? attendanceProvider.getWeeklyAttendance(
                                        startday2, endday2)
                                    : attendanceProvider.getWeeklyAttendance(
                                        startday4, endday4);
                                calendarView = CalendarView.week;
                                datechange = startday2 != null
                                    ? '$startday3 - $endday3'
                                    : '$startday - $endday';
                                shiftvalue = false;
                              } else {
                                attendanceProvider.getMonthlyAttendance(
                                  _month != ""
                                      ? _month
                                      : DateFormat('MMMM')
                                          .format(DateTime.now()),
                                  _year != ""
                                      ? _year
                                      : DateFormat('yyyy')
                                          .format(DateTime.now()),
                                );
                                calendarView = CalendarView.month;
                                datechange = DateFormat('MMMM yyy')
                                    .format(DateTime.now())
                                    .toString();
                                shiftvalue = true;
                              }
                            });
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.white,
                            child: CircleAvatar(
                                radius: 27,
                                backgroundColor: AppColors.primaryDarkColor,
                                child: Icon(Iconsax.calendar_search)),
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width + 56,
                    child: SfCalendar(
                      key: ValueKey(calendarView),
                      allowedViews: const [
                        CalendarView.month,
                        CalendarView.week
                      ],
                      showDatePickerButton: true,
                      allowAppointmentResize: true,
                      showCurrentTimeIndicator: true,
                      showNavigationArrow: true,
                      // showTodayButton: true,
                      headerHeight: 56.0,

                      onTap: (CalendarTapDetails c) {
                        TimeSheet? timeSheet =
                            attendanceProvider.getDetails(c.date);
                        if (timeSheet != null) {
                          Dialogs.showAttendance(
                              context: context, timeSheet: timeSheet);
                        }
                      },
                      onViewChanged: (viewChangedDetails) {
                        if (calendarView == CalendarView.month) {
                          viewChanged(
                              viewChangedDetails, attendanceProvider, true);
                        } else if (calendarView == CalendarView.week) {
                          viewChanged(
                              viewChangedDetails, attendanceProvider, false);
                        }
                      },
                      monthViewSettings: const MonthViewSettings(
                        appointmentDisplayMode:
                            MonthAppointmentDisplayMode.indicator,
                        showAgenda: false,
                        agendaItemHeight: 40.0,
                        agendaViewHeight: 56.0,
                      ),
                      view: calendarView,
                      dataSource:
                          MeetingDataSource(attendanceProvider.meetings),
                      backgroundColor: Colors.white,
                      todayHighlightColor: Colors.green,
                    ),
                  ),
                ),
                if (datechange != '')
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      CText(
                        text: datechange,
                        textcolor: AppColors.primaryDarkColor,
                        size: Sizes.TEXT_SIZE_20,
                        fontw: FontWeight.w500,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          color: AppColors.primaryDarkColor,
                          height: 1.0,
                        ),
                      ),
                    ],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CText(
                            text: "Total Shifts",
                            textcolor: AppColors.primaryDarkColor,
                            size: Sizes.TEXT_SIZE_24,
                            fontw: FontWeight.bold,
                          ),
                          CText(
                            text: attendanceProvider.meetings.length.toString(),
                            textcolor: AppColors.dark,
                            size: Sizes.TEXT_SIZE_24,
                            fontw: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
    }));
  }

  void viewChanged(ViewChangedDetails viewChangedDetails,
      AttendanceProvider attendanceProvider, bool month) {
    if (month) {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
        setState(() {
          _month = DateFormat('MMMM')
              .format(viewChangedDetails
                  .visibleDates[viewChangedDetails.visibleDates.length ~/ 2])
              .toString();
          _year = DateFormat('yyyy')
              .format(viewChangedDetails
                  .visibleDates[viewChangedDetails.visibleDates.length ~/ 2])
              .toString();
          datechange = DateFormat('MMMM yyy')
              .format(viewChangedDetails
                  .visibleDates[viewChangedDetails.visibleDates.length ~/ 2])
              .toString();
        });
        attendanceProvider.getMonthlyAttendance(_month, _year);
        print(_month);
        print(_year);
      });
    } else {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
        var currentWeekday = viewChangedDetails
            .visibleDates[viewChangedDetails.visibleDates.length ~/ 2].weekday;
        var offset = currentWeekday - DateTime.sunday;
        if (offset < 0) {
          offset = 7 + offset;
        }
        var sunday = viewChangedDetails
            .visibleDates[viewChangedDetails.visibleDates.length ~/ 2]
            .subtract(Duration(days: offset));
        var saturday = sunday.add(Duration(days: 6));
        setState(() {
          startday2 = DateFormat("yyyy-MM-dd").format(sunday);
          endday2 = DateFormat("yyyy-MM-dd").format(saturday);
          startday3 = DateFormat('dd MMMM').format(sunday);
          endday3 = DateFormat('dd MMMM').format(saturday);
          datechange = '$startday3 - $endday3';
        });
        attendanceProvider.getWeeklyAttendance(startday2, endday2);
        print(startday2);
        print(endday2);
      });
    }
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
