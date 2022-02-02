class EmployeeRole {
  int? roleId;
  String name;

  EmployeeRole({
    this.roleId,
    required this.name,
  });

  factory EmployeeRole.fromJson(Map<String, dynamic> json) {
    return EmployeeRole(
      roleId: json['roleId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'roleId': roleId,
        'name': name,
      };
}
