import 'package:cityinfluencers_mobile/models/influencer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
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
    initializeDateFormatting();
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/profilebanner.jpg"), fit: BoxFit.cover)),
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: Container(
                alignment: const Alignment(0.0, 2.5),
                child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/profileplaceholder.png"),
                  radius: 60.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            influencer!.user.firstName + " " + influencer!.user.name,
            style: const TextStyle(
                fontSize: 25.0,
                color: Colors.black,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            influencer!.user.location.name +
                ", " +
                influencer!.user.location.postalCode,
            style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black87,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Verjaardag: " +
                DateFormat.MMMMd("nl")
                    .format(DateTime.parse(influencer!.user.birthDate)),
            style: const TextStyle(
                fontSize: 15.0,
                color: Colors.black87,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Influencer",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w500),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        RichText(
                          text: const TextSpan(children: [
                            WidgetSpan(child: Icon(Icons.facebook_rounded, size: 28, color: Colors.blue),
                          ), 
                          TextSpan(text: "Facebook", style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600)
                          ),]),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        const Text(
                          "15,000 followers",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
         
        ],
      ),
    );
  }
}
