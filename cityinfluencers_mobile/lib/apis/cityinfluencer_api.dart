import 'package:cityinfluencers_mobile/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:cityinfluencers_mobile/models/campaign.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class CityInfluencerApi {
  static String server = 'city-influencers-api.loca.lt';

  // ---------- Users ---------------
  // REST API call: GET /users
  static Future<List<User>> fetchUsers() async {
    var url = Uri.https(server, '/users');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  // REST API call: GET /users/1
  static Future<User> fetchUser(int id) async {
    var url = Uri.https(server, '/users/' + id.toString());

    final response = await http.get(url);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
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
    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }

  // ---------- Campaigns ---------------
  // REST API call: GET /campaigns
  static Future<List<Campaign>> fetchCampaigns() async {
    var url = Uri.https(server, '/campaigns');

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

  static Future<User> auth(String email, String password) async {
    final Map<String, String> _queryparameter = <String, String>{
      'email': email
    };
    var url = Uri.https(server, '/users', _queryparameter);
    final response = await http.get(url);
    List jsonResponse = json.decode(response.body);
    List<User> users = jsonResponse.map((user) => User.fromJson(user)).toList();
    User temp = users[0];
    if (temp.password == password) {
      return temp;
    } else {
      throw Exception("Sorry, e-mail of wachtwoord is verkeerd.");
    }
  }
}
