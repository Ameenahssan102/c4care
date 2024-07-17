class LoginResModel {
  String jwtToken;
  String email;
  String name;
  String mobile;

  LoginResModel({
    required this.jwtToken,
    required this.email,
    required this.name,
    required this.mobile,
  });

  factory LoginResModel.fromJson(Map<String, dynamic> json) => LoginResModel(
    jwtToken: json["jwtToken"],
    email: json["email"],
    name: json["name"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "jwtToken": jwtToken,
    "email": email,
    "name": name,
    "mobile": mobile,
  };
}
