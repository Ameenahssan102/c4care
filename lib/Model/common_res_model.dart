class CommonRes {
  String message;

  CommonRes({
    required this.message,
  });

  factory CommonRes.fromJson(Map<String, dynamic> json) => CommonRes(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
