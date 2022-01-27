import 'package:cityinfluencers_mobile/models/campaignstatus.dart';
import 'package:cityinfluencers_mobile/models/location.dart';
import 'package:cityinfluencers_mobile/models/submission.dart';

class Campaign {
  int id;
  Location location;
  CampaignStatus campaignStatus;
  List<Submission> submissions;
  String name;
  String description;
  String fotoUrl;

  Campaign(
      {required this.id,
      required this.location,
      required this.campaignStatus,
      required this.submissions,
      required this.name,
      required this.description,
      required this.fotoUrl});

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['campaignId'],
      location: Location.fromJson(json['location']),
      campaignStatus: CampaignStatus.fromJson(json['campaignStatus']),
      submissions: (json['submissions'] as List).map((i) => Submission.fromJson(i)).toList(),
      name: json['name'],
      description: json['description'],
      fotoUrl: json['fotoUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'campaignId': id,
        'location': location.toJson(),
        'campaignStatus': campaignStatus.toJson(),
        'submissions': submissions.map((i) => i.toJson()),
        'name': name,
        'description': description,
        'foto_url': fotoUrl
      };
}
