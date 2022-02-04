import 'package:cityinfluencers_mobile/models/influencer.dart';
import 'package:cityinfluencers_mobile/pages/campaignDetail.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/campaign.dart';
import '../apis/cityinfluencer_api.dart';
import '../widgets/navigation.dart';

class HomePage extends StatefulWidget {
  final String? username;
  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Influencer? influencer;
  List<Campaign> _campaigns = [];
  List<Campaign> _filteredCampaigns = [];
  int count = 0;

  //beginstate checks
  @override
  void initState() {
    super.initState();
    _getStarted(widget.username);
  }

  //opvragen van de user gegevens
  void _getStarted(String? username) async {
    await CityInfluencerApi.fetchUser(username!).then((result) {
      setState(() {
        influencer = result;
      });
    });
    await CityInfluencerApi.fetchRecCampaigns(influencer!.influencerId).then((result) {
      setState(() {
        _campaigns = result.toList();
        _filteredCampaigns = result.toList();
        count = result.length;
      });
    });
  }


  //build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        //Navigation drawer
        drawer: _loadNavigation(),
        body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child:
        Container(
          color: Colors.white,
          child: Column(children: [
            Stack(
                alignment: Alignment.bottomCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 200.0,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/bannerhome.jpg'))),
                        ),
                      )
                    ],
                  ),
                ]),
            const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Aanbevolen campagnes",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold))),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 40.0,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0.0),
                    hintText: "Zoeken...",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ), // icon is 48px widget.
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                  onChanged: (String string) {
                    _onSearchChanged(string);
                  },
                ),
              ),
            ),
            _recListItems(),
          ]),
        )));
  }

  ListView _recListItems() {
    return ListView.builder(
      itemCount: count,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int position) {
        return Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.10,
                right: MediaQuery.of(context).size.width * 0.10),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                    maxWidth: 64,
                    maxHeight: 64,
                  ),
                  child: CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage(_filteredCampaigns[position].fotoUrl)),
                ),
                title: Text(_filteredCampaigns[position].name),
                trailing: const Icon(Icons.arrow_right_outlined),
                onTap: () {
                  _navigateToCampaign(
                      widget.username, _filteredCampaigns[position].id);
                },
              ),
            ));
      },
    );
  }

  void _navigateToCampaign(String? userName, int campaignId) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              CampaignDetailPage(username: userName, id: campaignId)),
    );
  }

  void _onSearchChanged(String string) {
    setState(() {
      _filteredCampaigns = _campaigns
          .where((i) => i.name.toLowerCase().contains(string.toLowerCase()))
          .toList();
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
}
