import 'package:cityinfluencers_mobile/models/campaignstatus.dart';
import 'package:cityinfluencers_mobile/models/location.dart';
import 'package:cityinfluencers_mobile/models/submission.dart';

class Campaign {
  int id;
  Location location;
  CampaignStatus campaignStatus;
  String name;
  String description;
  String startDate;
  String endDate;
  String fotoUrl;

  Campaign(
      {required this.id,
      required this.location,
      required this.campaignStatus,
      required this.name,
      required this.description,
      required this.startDate,
      required this.endDate,
      required this.fotoUrl});

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['campaignId'],
      location: Location.fromJson(json['location']),
      campaignStatus: CampaignStatus.fromJson(json['campaignStatus']),
      name: json['name'],
      description: json['description'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      fotoUrl: json['fotoUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'campaignId': id,
        'location': location.toJson(),
        'campaignStatus': campaignStatus.toJson(),
        'name': name,
        'description': description,
        'foto_url': fotoUrl
      };
}
