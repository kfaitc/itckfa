class LoginReponseModel {
  final String message;
  final String token;
  final dynamic user;
  LoginReponseModel({
    required this.token,
    required this.message,
    required this.user,
  });
  factory LoginReponseModel.fromJson(Map<String, dynamic> json) {
    return LoginReponseModel(
      message: json["message"] ?? "",
      token: json["token"] ?? "",
      user: json["user"],
    );
  }
}

class LoginRequestModel {
  late String email;
  late String password;
  LoginRequestModel({
    required this.email,
    required this.password,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": email.trim(),
      "password": password.trim(),
    };
    return map;
  }
}
