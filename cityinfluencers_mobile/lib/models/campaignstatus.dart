class CampaignStatus {
  int? statusId;
  String name;

  CampaignStatus({this.statusId, required this.name});

  factory CampaignStatus.fromJson(Map<String, dynamic> json) {
    return CampaignStatus(
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
