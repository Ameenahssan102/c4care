
class VersionModel {
    String? id;
    int? androidVersion;
    int? androidSupportingVersion;
    bool? androidServerDown;
    int? iosVersion;
    int? iosSupportingVersion;
    bool? iosServerDown;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? appstoreUrl;
    String? contactNo;
    String? playstoreUrl;

    VersionModel({
        this.id,
        this.androidVersion,
        this.androidSupportingVersion,
        this.androidServerDown,
        this.iosVersion,
        this.iosSupportingVersion,
        this.iosServerDown,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.appstoreUrl,
        this.contactNo,
        this.playstoreUrl,
    });

    factory VersionModel.fromJson(Map<String, dynamic> json) => VersionModel(
        id: json["_id"],
        androidVersion: json["androidVersion"],
        androidSupportingVersion: json["androidSupportingVersion"],
        androidServerDown: json["androidServerDown"],
        iosVersion: json["iosVersion"],
        iosSupportingVersion: json["iosSupportingVersion"],
        iosServerDown: json["iosServerDown"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        appstoreUrl: json["appstoreUrl"],
        contactNo: json["contactNo"],
        playstoreUrl: json["playstoreUrl  "],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "androidVersion": androidVersion,
        "androidSupportingVersion": androidSupportingVersion,
        "androidServerDown": androidServerDown,
        "iosVersion": iosVersion,
        "iosSupportingVersion": iosSupportingVersion,
        "iosServerDown": iosServerDown,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "appstoreUrl": appstoreUrl,
        "contactNo": contactNo,
        "playstoreUrl  ": playstoreUrl,
    };
}
