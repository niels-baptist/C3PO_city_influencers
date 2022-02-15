import 'package:cityinfluencers_mobile/models/influencer.dart';
import 'package:cityinfluencers_mobile/pages/influencerEdit.dart';
import 'package:cityinfluencers_mobile/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../models/user.dart';
import '../apis/cityinfluencer_api.dart';
import '../widgets/navigation.dart';

class ProfilePage extends StatefulWidget {
  final String? username;
  Widget _body = const CircularProgressIndicator();
  ProfilePage({Key? key, required this.username}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Influencer? influencer;
  final Storage storage = Storage();

  //beginstate checks
  @override
  void initState() {
    _getUser(widget.username);
    super.initState();
    initializeDateFormatting();
  }

  //opvragen van de user gegevens
  void _getUser(String? username) async {
    await CityInfluencerApi.fetchUser(username!).then((result) {
      setState(() {
        influencer = result;
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        //Navigation drawer
        drawer: _loadNavigation(),
        body: Column(
          children: [
            Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/profilebanner.jpg"),
                              fit: BoxFit.cover)),
                      child: FutureBuilder(
                future: storage.getFile(influencer!.pictureUrl!),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Container(
                          alignment: const Alignment(0.0, 2.5),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(snapshot.data!),
                            radius: 60.0,
                          ),
                        ),
                      );}
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return Container();
                    
                  
                })),
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
              height: 15,
            ),
            SizedBox(
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      _navigateToEdit(influencer!);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPrimary: Colors.white),
                    child: const Text('Instellingen'))),
            Card(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
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
                              WidgetSpan(
                                child: Icon(Icons.facebook_rounded,
                                    size: 28, color: Colors.blue),
                              ),
                              TextSpan(
                                  text: "Facebook",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600)),
                            ]),
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
        ));
  }

  void _navigateToEdit(Influencer influencer) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => InfluencerEditPage(
                influencer: influencer,
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
