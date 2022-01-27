// ignore_for_file: file_names

import 'dart:io';

import 'package:cityinfluencers_mobile/apis/cityinfluencer_api.dart';
import 'package:cityinfluencers_mobile/models/campaign.dart';
import 'package:cityinfluencers_mobile/models/domain.dart';
import 'package:cityinfluencers_mobile/models/influencer.dart';
import 'package:cityinfluencers_mobile/pages/campaigns.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/navigation.dart';

class CampaignDetailPage extends StatefulWidget {
  final String? username;
  final int? id;
  const CampaignDetailPage({Key? key, required this.username, required this.id})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CampaignDetailPageState();
}

class _CampaignDetailPageState extends State<CampaignDetailPage> {
  Influencer? influencer;
  Campaign? campaign;

  @override
  void initState() {
    _getUser(widget.username);
    _getCampaign(widget.id);
    super.initState();
  }

  Future<Influencer?> _getUser(String? username) async {
    await CityInfluencerApi.fetchUser(username!).then((result) {
      setState(() {
        influencer = result;
      });
    });
  }

  Future<Campaign?> _getCampaign(int? id) async {
    await CityInfluencerApi.fetchCampaign(id!).then((result) {
      setState(() {
        campaign = result;
      });
    });
  }

  //build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("City Influencers")),
        ),
        //Navigation drawer
        drawer: _loadNavigation(),
        body: Container(
            padding: const EdgeInsets.all(5.0),
            color: Colors.white,
            child: Column(children: [
              Row(
                children: [
                  BackButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CampaignPage(username: widget.username)));
                    },
                    color: Colors.deepPurple,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(campaign!.name,
                          style: const TextStyle(
                              fontSize: 25, color: Colors.deepPurpleAccent))),
                ],
              ),
              Container(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 3.0),
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: FadeInImage(
                    image: NetworkImage(campaign!.fotoUrl),
                    placeholder: const AssetImage('loading.png'),
                  )),
              const Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 3.0),
                child: Text(
                  "Beschrijving:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.deepPurpleAccent),
                ),
              ),
              Text(campaign!.description),
              const Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Text(
                    "Locatie:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.deepPurpleAccent),
                  )),
              Text(campaign!.location.name +
                  ", " +
                  campaign!.location.postalCode),
            ])));
  }

  _loadNavigation() {
    if (influencer == null) {
      return const Drawer(child: Text("Loading..."));
    } else {
      return NavigationWidget(influencer: influencer!);
    }
  }
}
