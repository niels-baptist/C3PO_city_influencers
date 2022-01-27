class SubmissionStatus {
  int? statusId;
  String name;

  SubmissionStatus({
    this.statusId,
    required this.name,
  });

  factory SubmissionStatus.fromJson(Map<String, dynamic> json) {
    return SubmissionStatus(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
