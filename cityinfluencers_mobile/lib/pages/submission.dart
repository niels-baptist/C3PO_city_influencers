import 'package:cityinfluencers_mobile/apis/cityinfluencer_api.dart';
import 'package:cityinfluencers_mobile/models/campaign.dart';
import 'package:cityinfluencers_mobile/models/influencer.dart';
import 'package:cityinfluencers_mobile/models/submission.dart';
import 'package:cityinfluencers_mobile/pages/campaignDetail.dart';
import 'package:cityinfluencers_mobile/widgets/navigation.dart';
import 'package:flutter/material.dart';

class SubmissionPage extends StatefulWidget {
  const SubmissionPage(
      {Key? key, required this.influencerId, this.username, required this.campaignId})
      : super(key: key);
  final int? influencerId;
  final String? username;
  final int campaignId;

  @override
  State<StatefulWidget> createState() => _SubmissionPageState();
}

class _SubmissionPageState extends State<SubmissionPage> {
  Influencer? influencer;
  Campaign? campaign;
  Submission? submission;
  //beginstate checks
  @override
  void initState() {
    _getUser(widget.username);
    _getCampaign(widget.campaignId);
    _getSubmission(widget.influencerId, widget.campaignId);
    super.initState();
  }

  //opvragen van de user gegevens
  void _getUser(String? username) {
    CityInfluencerApi.fetchUser(username!).then((result) {
      setState(() {
        influencer = result;
      });
    });
  }

  void _getCampaign(int? id) {
    CityInfluencerApi.fetchCampaign(id!).then((result) {
      setState(() {
        campaign = result;
      });
    });
  }

  void _getSubmission(int? influencerId, int? campaignId) {
    CityInfluencerApi.fetchSubmission(influencerId!, campaignId!)
        .then((result) {
      setState(() {
        submission = result;
      });
    });
  }

  //build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: 
          Align(
            alignment: Alignment.topRight,
            child: Image.asset("assets/ci-logo.png", fit: BoxFit.cover, height: 100),
          ),
        ),
        body: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                  child: Text(campaign!.name,
                  style: const TextStyle(
                    fontSize: 25, color: Colors.black)
                  )
              ),
                
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.10,
                  right: MediaQuery.of(context).size.width * 0.10,
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Afbeelding Url',
                  ),
                  onChanged: (String string) {
                    submission!.url = string;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.10,
                  right: MediaQuery.of(context).size.width * 0.10,
                ),
                child: TextField(
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'Jou Post',
                  ),
                  onChanged: (String string) {
                    submission!.description = string;
                  },
                ),
              ),
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
