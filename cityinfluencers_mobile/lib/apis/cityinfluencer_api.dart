import 'package:cityinfluencers_mobile/models/domain.dart';
import 'package:cityinfluencers_mobile/models/influencer.dart';
import 'package:cityinfluencers_mobile/models/location.dart';
import 'package:cityinfluencers_mobile/models/submission.dart';
import 'package:cityinfluencers_mobile/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:cityinfluencers_mobile/models/campaign.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class CityInfluencerApi {
  // static String server = 'java-rest-api-c3po.westeurope.cloudapp.azure.com';
  static String server = 'c3poapi.azurewebsites.net';
  // ---------- Users ---------------
  // REST API call: GET /users
  static Future<List<User>> fetchUsers() async {
    var url = Uri.http(server, '/users');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }


  // REST API call: GET /users/username
  static Future<User> getUser(String userName) async {
    var url = Uri.https(server, '/users/username/' + userName);
    final response = await http.get(url);
    User user = User.fromJson(jsonDecode(response.body));
    return user;
  }

  // REST API call: POST /users
  static Future<User> createUser(User user) async {
    var url = Uri.https(server, '/users');

    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );
    return User.fromJson(jsonDecode(response.body));
  }


  // ---------- Campaigns ---------------
  // REST API call: GET /campaigns
  static Future<List<Campaign>> fetchCampaigns() async {
    var url = Uri.https(server, '/campaigns/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((campaign) => Campaign.fromJson(campaign))
          .toList();
    } else {
      throw Exception('Failed to load campaigns');
    }
  }

  // REST API call: GET /campaigns/{id}
  static Future<Campaign> fetchCampaign(int id) async {
    var url = Uri.https(server, '/campaigns/' + id.toString());
    final response = await http.get(url);
    Campaign campaign = Campaign.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return campaign;
    } else {
      throw Exception("Sorry, deze campagne werd niet gevonden.");
    }
  }

  // REST API call: GET /campaigns/recomended/{influencerId}
  static Future<List<Campaign>> fetchRecCampaigns(int? influencerId) async {
    var url =
        Uri.https(server, '/campaigns/influencer/' + influencerId.toString());
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((campaign) => Campaign.fromJson(campaign))
          .toList();
    } else {
      throw Exception('Failed to load campaigns');
    }
  }

  // ---------- Domains ---------------
  // REST API call: GET /domains
  static Future<List<Domain>> fetchDomains() async {
    var url = Uri.https(server, '/domains');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((domain) => Domain.fromJson(domain)).toList();
    } else {
      throw Exception('Failed to load domains');
    }
  }

  // ---------- Locations ---------------
  // REST API call: GET /locations
  static Future<List<Location>> fetchLocations() async {
    var url = Uri.https(server, '/locations');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((location) => Location.fromJson(location))
          .toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }

  // ---------- Influencers ---------------
  //authenticatie gebaseerd op GET /influencers/username/{username}
  static Future<Influencer> auth(String userName, String password) async {
    var url = Uri.https(server, '/influencers/username/' + userName);
    final response = await http.get(url);
    Influencer influencer = Influencer.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      if (influencer.user.password == password) {
        return influencer;
      } else {
        throw Exception("Sorry, wachtwoord is verkeerd.");
      }
    } else {
      throw Exception("Sorry, gebruiker niet gevonden.");
    }
  }

  // REST API call: POST /influencers
  static Future<Influencer> createInfluencer(Influencer influencer) async {
    var url = Uri.https(server, '/influencers');

    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(influencer),
    );
    return Influencer.fromJson(jsonDecode(response.body));
  }

  // REST API call: GET /influencers/username
  static Future<Influencer> fetchUser(String userName) async {
    var url = Uri.https(server, '/influencers/username/' + userName);
    final response = await http.get(url);
    Influencer influencer = Influencer.fromJson(jsonDecode(response.body));
    return influencer;
  }
  
  // ---------- Submissions ---------------
  // REST API call: GET /submissions/{influencerId}/{campaignId}
  static Future<Submission> fetchSubmission(int influencerId, int campaignId) async {
    var url = Uri.https(server, '/submissions/' + influencerId.toString() + '/' + campaignId.toString());
    final response = await http.get(url);
    Submission submission = Submission.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return submission;
    } else {
      throw Exception("Sorry, deze submission werd niet gevonden.");
    }
  }

   // REST API call: PUT /submissions/1
  static Future<Submission> updateSubmission(int id, Submission submission) async {
    var url =
        Uri.https(server, '/submissions/' + id.toString(), {"_expand": "collection"});

    final http.Response response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(submission),
    );
    if (response.statusCode == 200) {
      return Submission.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update submission');
    }
  }

}
