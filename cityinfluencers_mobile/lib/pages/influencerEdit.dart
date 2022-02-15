// ignore_for_file: file_names
import 'package:cityinfluencers_mobile/models/domain.dart';
import 'package:cityinfluencers_mobile/models/influencer.dart';
import 'package:cityinfluencers_mobile/models/location.dart';
import 'package:cityinfluencers_mobile/pages/profile.dart';
import 'package:cityinfluencers_mobile/services/storage_service.dart';
import 'package:cityinfluencers_mobile/widgets/locationdropdownbutton.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import '../apis/cityinfluencer_api.dart';

class InfluencerEditPage extends StatefulWidget {
  final Influencer influencer;
  Widget _body = const CircularProgressIndicator();
  InfluencerEditPage({Key? key, required this.influencer}) : super(key: key);

  @override
  State<StatefulWidget> createState() {return _InfluencerEditPageState();}
}

class _InfluencerEditPageState extends State<InfluencerEditPage> {
  final _formKey = GlobalKey<FormState>();
  List<Domain> _domains = [];
  List<Location> _locations = [];
  final Storage storage = Storage();
  final List<Domain> _selectedDomains = [];
  Location? _location;

  //beginstate checks
  @override
  void initState() {
    _getStarted();
    super.initState();
  }

  //opvragen van de nodige gegevens
  void _getStarted() async {
    await CityInfluencerApi.fetchLocations().then((result) {
      setState(() {
        _locations = result.toList();
      });
    });
    await CityInfluencerApi.fetchDomains().then((result) {
      setState(() {
        _domains = result.toList();
      });
    });
    setState(() => widget._body = realBody());
  }

  //build
  @override
  Widget build(BuildContext context) {
    return widget._body;
  }

  //apparte body om null error te vermijden tijdens loading
  Widget realBody() {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          title: Align(
            alignment: Alignment.topRight,
            child: Image.asset("assets/ci-logo.png",
                fit: BoxFit.cover, height: 100),
          ),
        ),
        body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Form(
                  key: _formKey,
                    child: Column(children: <Widget>[
                  //titel
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Verander je gegevens',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )),
                  //profielafbeelding veranderen
                  Row(
                    children: [
                      FutureBuilder(
                          future:
                              storage.getFile(widget.influencer.pictureUrl!),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.2),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(snapshot.data!),
                                      radius: 30.0,
                                    ),
                                  ));
                            }
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                !snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            return Container();
                          }),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1),
                        child: ElevatedButton(
                            onPressed: () async {
                              final results =
                                  await FilePicker.platform.pickFiles(
                                allowMultiple: false,
                                type: FileType.custom,
                                allowedExtensions: ['png', 'jpg'],
                              );

                              if (results == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('No File selected.')));
                                return null;
                              }

                              final path = results.files.single.path!;
                              final fileName = results.files.single.name;

                              storage
                                  .uploadFile(path, fileName)
                                  .then((value) => print('done'));

                              _onProfilePicChange(fileName);
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                onPrimary: Colors.white),
                            child: const Text('Profielfoto')),
                      )
                    ],
                  ),
                  //email veranderen
                  Container(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.10,
                      right: MediaQuery.of(context).size.width * 0.10,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        hintText: widget.influencer.user.email,
                      ),
                      onChanged: (String string) {
                        widget.influencer.user.email = string;
                      },
                    ),
                  ),
                  //locatie veranderen
                  Container(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.10,
                        right: MediaQuery.of(context).size.width * 0.10,
                      ),
                      child: LocationDropdownButton(
                        labelText: "Locatie",
                        selectedLocation: _location,
                        locations: _locations,
                        onLocationSelected: (location) {
                          _onLocationChanged(location);
                        },
                      )),
                  //wachtwoord veranderen    
                  Container(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.10,
                      right: MediaQuery.of(context).size.width * 0.10,
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Wachtwoord',
                      ),
                      onChanged: (String string) {
                        widget.influencer.user.password = string;
                      },
                      obscureText: true,
                    ),
                  ),
                  //titel
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'Voorkeur campagnes',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )),
                  //veranderen domains
                  Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.10,
                          right: MediaQuery.of(context).size.width * 0.10,
                          bottom: MediaQuery.of(context).size.height * 0.05),
                      child: MultiSelectFormField(
                        chipBackGroundColor: Colors.cyan,
                        chipLabelStyle: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        dialogTextStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        checkBoxActiveColor: Colors.cyan,
                        checkBoxCheckColor: Colors.cyanAccent,
                        dialogShapeBorder: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0))),
                        title: const Text(
                          "domains",
                          style: TextStyle(fontSize: 16),
                        ),
                        dataSource: [
                          for (Domain domain in _domains)
                            {
                              "display": domain.name,
                              "value": domain,
                            }
                        ],
                        textField: 'display',
                        valueField: 'value',
                        okButtonLabel: 'OK',
                        cancelButtonLabel: 'CANCEL',
                        hintWidget: const Text('Please choose one or more'),
                        initialValue: _selectedDomains,
                        onSaved: (value) {
                          if (value == null) {
                            for (Domain domain in widget.influencer.domains!) {
                              _selectedDomains.add(domain);
                            }
                          }
                          setState(() {
                            for (Domain domain in value) {
                              _selectedDomains.add(domain);
                            }
                          });
                        },
                      )),
                  //submit knop
                  SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            onPrimary: Colors.white),
                        onPressed: () {
                          _location ??= widget.influencer.user.location;
                          _onSubmit(
                              widget.influencer, _selectedDomains, _location!);
                        },
                        child: const Text('Submit'),
                      ))
                ])))));
  }

  //functie voor POST van de post
  void _onSubmit(
      Influencer influencer, List<Domain> domains, Location location) async {
    if (domains.isNotEmpty) {
      influencer.domains = domains;
    }
    influencer.user.location = location;
    await CityInfluencerApi.updateInfluencer(influencer);
    _navigateToProfile(influencer.user.userName);
  }

  //functie bij veranderen van profile picture
  void _onProfilePicChange(String url) {
    setState(() {
      widget.influencer.pictureUrl = url;
    });
  }

  //navigation call voor profielpagina
  void _navigateToProfile(String username) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage(username: username)),
    );
  }

  //functie bij veranderen van locatie
  void _onLocationChanged(Location location) {
    setState(() {
      _location = location;
    });
  }
}
