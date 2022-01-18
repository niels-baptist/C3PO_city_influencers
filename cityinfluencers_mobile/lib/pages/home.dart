import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/campaign.dart';
import '../apis/cityinfluencer_api.dart';
import '../widgets/navigation.dart';
class HomePage extends StatefulWidget {
  final int id;
  const HomePage({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;
  List<Campaign?> campaignList = [];
  int count = 0;

  //beginstate checks
  @override
  void initState() {
    super.initState();
    _getCampaigns();
    _getUser(widget.id);
  }

  //opvragen van de user gegevens
  void _getUser(int id) {
    CityInfluencerApi.fetchUser(id).then((result) {
      setState(() {
        user = result;
      });
    });
  }

  void _getCampaigns() {
    CityInfluencerApi.fetchCampaigns().then((result) {
      setState(() {
        campaignList = result.toList();
        count = result.length;
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
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Posts in afwachting", style: TextStyle(fontSize: 25, color: Colors.deepPurpleAccent))),
            _postsListItems(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Ingezonden campagnes", style: TextStyle(fontSize: 25, color: Colors.deepPurpleAccent))),
            _recListItems(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Posts in afwachting", style: TextStyle(fontSize: 25, color: Colors.deepPurpleAccent))),
            _sentListItems()
          ],
        ),
      ),
    );
  }
  ListView _postsListItems() {
      return ListView.builder(
      itemCount: count,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Text(campaignList[position]!.name.substring(0, 1)),
            ),
            title: Text(campaignList[position]!.name),
            onTap: () {
             // _navigateToProfile(userList[position].id);
            },
          ),
        );
      },
    );
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
              backgroundColor: Colors.deepPurple,
              child: Text(campaignList[position]!.name.substring(0, 1)),
            ),
            title: Text(campaignList[position]!.name),
            onTap: () {
             // _navigateToProfile(userList[position].id);
            },
          ),
        );
      },
    );
  }  
  ListView _sentListItems() {
      return ListView.builder(
      itemCount: count,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Text(campaignList[position]!.name.substring(0, 1)),
            ),
            title: Text(campaignList[position]!.name),
            onTap: () {
             // _navigateToProfile(userList[position].id);
            },
          ),
        );
      },
    );
  }
  
  _loadNavigation() {
    if (user == null) {
      return const Drawer(child: Text("Loading..."));
    } else {
      return NavigationWidget(user: user!);
    }
  }
}