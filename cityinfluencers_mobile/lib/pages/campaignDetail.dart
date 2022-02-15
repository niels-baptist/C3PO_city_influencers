// ignore_for_file: file_names

import 'dart:io';
import 'package:cityinfluencers_mobile/apis/cityinfluencer_api.dart';
import 'package:cityinfluencers_mobile/models/campaign.dart';
import 'package:cityinfluencers_mobile/models/domain.dart';
import 'package:cityinfluencers_mobile/models/influencer.dart';
import 'package:cityinfluencers_mobile/models/submission.dart';
import 'package:cityinfluencers_mobile/pages/campaigns.dart';
import 'package:cityinfluencers_mobile/pages/home.dart';
import 'package:cityinfluencers_mobile/pages/submission.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import '../main.dart';
import '../widgets/navigation.dart';

class CampaignDetailPage extends StatefulWidget {
  final String? username;
  final int? id;
  Widget _body = const CircularProgressIndicator();
  CampaignDetailPage({Key? key, required this.username, required this.id})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CampaignDetailPageState();
}

class _CampaignDetailPageState extends State<CampaignDetailPage> {
  Influencer? influencer;
  Campaign? campaign;

  @override
  void initState() {
    _getStarted(widget.username);
    super.initState();
  }

  void _getStarted(String? username) async {
    await CityInfluencerApi.fetchUser(username!).then((result) {
      setState(() {
        influencer = result;
      });
    });
    await CityInfluencerApi.fetchCampaign(widget.id!).then((result) {
      setState(() {
        campaign = result;
      });
    });
    setState(() => widget._body = realBody());
  }

  //build
  @override
  Widget build(BuildContext context) {
    return widget._body;
  }

  Widget realBody() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: Align(
          alignment: Alignment.topRight,
          child:
              Image.asset("assets/ci-logo.png", fit: BoxFit.cover, height: 100),
        ),
      ),
        //Navigation drawer
        drawer: _loadNavigation(),
      body: Container(
          padding: const EdgeInsets.only(left: 50.0, bottom: 3.0, right: 50.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ClipOval(
                    child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(campaign!.fotoUrl),
                          placeholder: const AssetImage('assets/loading.png'),
                        ))),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(campaign!.name,
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Beschrijving:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      campaign!.description,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Locatie:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      )),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      campaign!.location.name +
                          ", " +
                          campaign!.location.postalCode,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Periode:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      campaign!.startDate.split('T')[0] +
                          ' - ' +
                          campaign!.endDate.split('T')[0],
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () {
                            _postNavigate(influencer!.influencerId,
                                influencer!.user.userName, campaign!.id);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              onPrimary: Colors.white),
                          child: const Text('Doe Mee')))),
            ],
          )),
    );
  }

  void _postNavigate(int? influencerId, String userName, int campaignId) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SubmissionPage(
                influencerId: influencerId,
                username: userName,
                campaignId: campaignId,
              )),
    );
  }
  _loadNavigation() {
    if (influencer == null) {
      return const Drawer(child: Text("Loading..."));
    } else {
      return NavigationWidget(influencer: influencer!);
    }
  }
}
