class Campaign {
  int id;
  int employeeId;
  int locationId;
  String name;
  String description;
  String fotoUrl;
  String status;

  Campaign({required this.id, required this.employeeId, required this.locationId, required this.name, required this.description, required this.fotoUrl, required this.status});

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'],
      employeeId: json['employeeId'],
      locationId: json['locationId'],
      name: json['name'],
      description: json['description'],
      fotoUrl: json['fotoUrl'],
      status: json ['status'],
      
    );
  }

  Map<String, dynamic> toJson() => {'employeeId': employeeId, 'locationId': locationId, 'name': name, 'description': description, 'fotoUrl': fotoUrl, 'status': status};
}