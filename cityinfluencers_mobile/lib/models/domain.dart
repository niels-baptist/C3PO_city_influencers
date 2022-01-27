class Domain {
  int id;
  String name;
  String description;

  Domain(
      {required this.id,
      required this.name,
      required this.description});

  factory Domain.fromJson(Map<String, dynamic> json) {
    return Domain(
      id: json['domainId'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'domainId': id,
        'name': name,
        'description': description,
      };
}
