import 'package:cityinfluencers_mobile/models/influencer.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../apis/cityinfluencer_api.dart';
import '../widgets/navigation.dart';
class ProfilePage extends StatefulWidget {
  final String? username;
  const ProfilePage({Key? key, required this.username}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Influencer? influencer;
  
  //beginstate checks
  @override
  void initState() {
    super.initState();
    _getUser(widget.username);
  }

  //opvragen van de user gegevens
  void _getUser(String? username) {
    CityInfluencerApi.fetchUser(username!).then((result) {
      setState(() {
        influencer = result;
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
      body: Container(),
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
