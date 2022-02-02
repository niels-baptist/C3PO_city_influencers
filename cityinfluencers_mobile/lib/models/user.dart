import 'package:cityinfluencers_mobile/models/location.dart';

class User {
  int? userId;
  String userName;
  String firstName;
  String name;
  String password;
  String birthDate;
  String email;
  Location location;

  User(
      {this.userId,
      required this.userName,
      required this.firstName,
      required this.name,
      required this.password,
      required this.birthDate,
      required this.email,
      required this.location});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['userName'],
      firstName: json['firstname'],
      name: json['lastname'],
      password: json['password'],
      birthDate: json['birthdate'],
      email: json['email'],
      location: Location.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'email': email,
        'password': password,
        'firstname': firstName,
        'lastname': name,
        'userName': userName,
        'birthdate': birthDate,
        'location': location,
      };
}
