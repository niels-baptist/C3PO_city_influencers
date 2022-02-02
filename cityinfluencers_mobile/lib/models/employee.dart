import 'package:cityinfluencers_mobile/models/employeerole.dart';
import 'package:cityinfluencers_mobile/models/user.dart';

class Employee {
  int? employeeId;
  EmployeeRole role;
  User user;

  Employee({
    this.employeeId,
    required this.role,
    required this.user,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employeeId: json['employeeId'],
      user: User.fromJson(json['user']),
      role: json['employee_role'],
    );
  }

  Map<String, dynamic> toJson() => {
        'employeeId': employeeId,
        'user': user,
        'employee_role': role,
      };
}
