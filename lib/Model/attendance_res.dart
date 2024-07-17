class AttendanceRes {
    bool? isCheckIn;
    DateTime? checkInTime;
    DateTime? checkOutTime;
    String? checkInTimeStr;
    String? checkOutTimeStr;
    String? monthlyShifts;
    String? weeklyShifts;

    AttendanceRes({
        this.isCheckIn,
        this.checkInTime,
        this.checkOutTime,
        this.checkInTimeStr,
        this.checkOutTimeStr,
        this.monthlyShifts,
        this.weeklyShifts,
    });

    factory AttendanceRes.fromJson(Map<String, dynamic> json) => AttendanceRes(
        isCheckIn: json["isCheckIn"],
        checkInTime: json["checkInTime"] == null ? null : DateTime.parse(json["checkInTime"]),
        checkOutTime: json["checkOutTime"] == null ? null : DateTime.parse(json["checkOutTime"]),
        checkInTimeStr: json["checkInTimeStr"],
        checkOutTimeStr: json["checkOutTimeStr"],
        monthlyShifts: json["monthlyShifts"],
        weeklyShifts: json["weeklyShifts"],
    );

    Map<String, dynamic> toJson() => {
        "isCheckIn": isCheckIn,
        "checkInTime": checkInTime?.toIso8601String(),
        "checkOutTime": checkOutTime?.toIso8601String(),
        "checkInTimeStr": checkInTimeStr,
        "checkOutTimeStr": checkOutTimeStr,
        "monthlyShifts": monthlyShifts,
        "weeklyShifts": weeklyShifts,
    };
}
