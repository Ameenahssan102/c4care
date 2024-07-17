class TimeSheet {
  String? status;
  String? checkInTime;
  Client? client;
  String? checkOutTime;
  
  TimeSheet({
    this.status,
    this.checkInTime,
    this.checkOutTime,
    this.client,
  });

  factory TimeSheet.fromJson(Map<String, dynamic> json) => TimeSheet(
        status: json["status"],
        checkInTime: json["checkInTime"],
        checkOutTime: json["checkOutTime"],
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "checkInTime": checkInTime,
        "checkOutTime": checkOutTime,
        "client": client?.toJson(),
      };
}

class Client {
  String? id;
  String? name;

  Client({
    this.id,
    this.name,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
