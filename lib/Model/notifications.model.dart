class NotificationsModel {
  int? totalPages;
  int? currentPage;
  List<Notifications>? notifications;

  NotificationsModel({
    this.totalPages,
    this.currentPage,
    this.notifications,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        notifications: json["notifications"] == null
            ? []
            : List<Notifications>.from(
                json["notifications"]!.map((x) => Notifications.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalPages": totalPages,
        "currentPage": currentPage,
        "notifications": notifications == null
            ? []
            : List<dynamic>.from(notifications!.map((x) => x.toJson())),
      };
}

class Notifications {
  String? id;
  String? title;
  String? content;
  DateTime? createdAt;

  Notifications({
    this.id,
    this.title,
    this.content,
    this.createdAt,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["_id"],
        title: json["title"],
        content: json["content"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "content": content,
        "createdAt": createdAt?.toIso8601String(),
      };
}
