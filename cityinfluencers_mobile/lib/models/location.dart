class Location {
  int locationId;
  String name;
  String postalCode;

  Location(
      {required this.locationId,
      required this.name,
      required this.postalCode});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      locationId: json['locationId'],
      name: json['name'],
      postalCode: json['postalCode'],
    );
  }

  Map<String, dynamic> toJson() => {
        'locationId': locationId,
        'name': name,
        'postalCode': postalCode,
      };
}
