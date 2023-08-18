// ignore_for_file: non_constant_identifier_names

class User {
  late String id;
  late String username;
  late String first_name;
  late String last_name;
  late String email;
  late String gender;
  late String from;
  late String tel;
  // Add whatever other properties you need to pull from the server here
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.first_name,
    required this.from,
    required this.gender,
    required this.last_name,
    required this.tel,
  });
  // This function will help you convert the deata you receive from the server
  // into an instance of User
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "id": id,
      "first_name": first_name.trim(),
      "last_name": last_name.trim(),
      "username": username.trim(),
      "gender": gender.trim(),
      "tel_num": tel.trim(),
      "known_from": from.trim(),
      "email": email.trim(),
    };
    return map;
  }
}
