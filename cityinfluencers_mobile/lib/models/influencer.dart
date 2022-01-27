import 'dart:convert';

import 'package:cityinfluencers_mobile/models/domain.dart';
import 'package:cityinfluencers_mobile/models/user.dart';

class Influencer {
  int? influencerId;
  User user;
  String gender;
  List<Domain>? domains;

  Influencer({
    this.influencerId,
    required this.user,
    required this.gender,
    this.domains,
  });

  factory Influencer.fromJson(Map<String, dynamic> json) {
    return Influencer(
      influencerId: json['influencerId'],
      user: User.fromJson(json['user']),
      gender: json['gender'], 
      domains: (json['domains'] as List).map((i) => Domain.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user,
        'gender': gender,
        'domains': domains,
      };
}
