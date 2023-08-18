// ignore_for_file: non_constant_identifier_names

class RegisterReponseModel {
  final String message;
  final String access_token;
  RegisterReponseModel({
    required this.message,
    required this.access_token,
  });
  factory RegisterReponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterReponseModel(
      message: json["message"] ?? "",
      access_token: json["access_token"] ?? "",
    );
  }
}

class RegisterRequestModel {
  late String first_name;
  late String last_name;
  late String control_user;
  late String email;
  late String gender;
  late String tel_num;
  late String password;
  late String password_confirmation;
  late String known_from;

  RegisterRequestModel({
    required this.email,
    required this.password,
    required this.first_name,
    required this.gender,
    required this.known_from,
    required this.last_name,
    required this.tel_num,
    required this.control_user,
    required this.password_confirmation,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "first_name": first_name.trim(),
      "last_name": last_name.trim(),
      "control_user": control_user,
      "email": email.trim(),
      "gender": gender.trim(),
      "tel_num": tel_num.trim(),
      "known_from": known_from.trim(),
      "password": password.trim(),
      "password_confirmation": password_confirmation.trim(),
    };
    return map;
  }
}

class RegisterReponseModel_update {
  final String message;
  RegisterReponseModel_update({
    required this.message,
  });
  factory RegisterReponseModel_update.fromJson(Map<String, dynamic> json) {
    return RegisterReponseModel_update(
      message: json["message"] ?? "",
    );
  }
}

class RegisterRequestModel_update {
  late String first_name;
  late String last_name;
  late String email;
  late String gender;
  late String tel_num;
  late String password;
  late String known_from;

  RegisterRequestModel_update({
    required this.email,
    required this.password,
    required this.first_name,
    required this.gender,
    required this.known_from,
    required this.last_name,
    required this.tel_num,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "first_name": first_name.trim(),
      "last_name": last_name.trim(),
      "email": email.trim(),
      "gender": gender.trim(),
      "tel_num": tel_num.trim(),
      "known_from": known_from.trim(),
      "password": password.trim(),
    };
    return map;
  }
}
