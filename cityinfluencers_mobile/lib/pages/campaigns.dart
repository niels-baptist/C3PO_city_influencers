import 'dart:io';

import 'package:cityinfluencers_mobile/models/campaign.dart';
import 'package:cityinfluencers_mobile/models/domain.dart';
import 'package:cityinfluencers_mobile/models/influencer.dart';
import 'package:cityinfluencers_mobile/pages/campaignDetail.dart';
import 'package:cityinfluencers_mobile/widgets/domaindropdownbutton.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../apis/cityinfluencer_api.dart';
import '../widgets/navigation.dart';

class CampaignPage extends StatefulWidget {
  final String? username;
  const CampaignPage({Key? key, required this.username}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CampaignPageState();
}

class _CampaignPageState extends State<CampaignPage> {
  final _formKey = GlobalKey<FormState>();
  Influencer? influencer;
  List<Campaign> _campaigns = [];
  List<Campaign> _filteredCampaigns = [];
  List<Domain> _domains = [];
  String _searchString = '';
  Domain? selectedDomain;
  int count = 0;

  //beginstate checks
  @override
  void initState() {
    _getUser(widget.username);
    _getCampaigns();
    _getDomains();
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

  Future<List<Campaign>?> _getCampaigns() async {
    await CityInfluencerApi.fetchCampaigns().then((result) {
      setState(() {
        _campaigns = result.toList();
        _filteredCampaigns = result.toList();
        count = result.length;
      });
    });
  }

  Future<List<Domain>?> _getDomains() async {
    await CityInfluencerApi.fetchDomains().then((result) {
      setState(() {
        _domains = result.toList();
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
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Campagnes",
                      style: TextStyle(
                          fontSize: 25, color: Colors.black))),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextFormField(
                            
                            decoration:
                                 const InputDecoration(hintText: "Zoeken...",
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ), // icon is 48px widget.
                                  ),),
                                 
                            onChanged: (String string) {
                              _onSearchChanged(string);
                            },
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: DomainDropdownButton(
                          labelText: "topic",
                          selectedDomain: selectedDomain,
                          domains: _domains,
                          onDomainSelected: (domain) {
                            _onDomainChanged(domain);
                          },
                        ),
                      ),
                    ],
                  )),
              _recListItems()
            ])));
  }

  ListView _recListItems() {
    return ListView.builder(
      itemCount: count,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.cyan,
              child: Text(_filteredCampaigns[position].name.substring(0, 1)),
            ),
            title: Text(_filteredCampaigns[position].name),
            onTap: () {
              _navigateToCampaign(
                  widget.username, _filteredCampaigns[position].id);
            },
          ),
        );
      },
    );
  }

  void _onDomainChanged(Domain domain) {
    setState(() {
      selectedDomain = domain;
    });
  }

  void _onSearchChanged(String string) {
    setState(() {
      _filteredCampaigns =
          _campaigns.where((i) => i.name.toLowerCase().contains(string.toLowerCase())).toList();
      count = _filteredCampaigns.length;
    });
  }

  _loadNavigation() {
    if (influencer == null) {
      return const Drawer(child: Text("Loading..."));
    } else {
      return NavigationWidget(influencer: influencer!);
    }
  }

  void _navigateToCampaign(String? userName, int campaignId) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              CampaignDetailPage(username: userName, id: campaignId)),
    );
  }
}
