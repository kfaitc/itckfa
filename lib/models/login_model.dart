class LoginReponseModel {
  final String message;
  final String errors;
  final String token;
  LoginReponseModel({
    required this.token,
    required this.message,
    required this.errors,
  });
  factory LoginReponseModel.fromJson(Map<String, dynamic> json) {
    return LoginReponseModel(
      message: json["message"] ?? "",
      errors: json["error"] ?? "",
      token: json["token"] ?? "",
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
