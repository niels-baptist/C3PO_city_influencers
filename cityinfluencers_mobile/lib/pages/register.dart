import 'package:cityinfluencers_mobile/apis/cityinfluencer_api.dart';
import 'package:cityinfluencers_mobile/models/influencer.dart';
import 'package:cityinfluencers_mobile/models/location.dart';
import 'package:cityinfluencers_mobile/pages/registerInfluencer.dart';
import 'package:cityinfluencers_mobile/widgets/locationdropdownbutton.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../main.dart';
import '../widgets/genderdropdownbutton.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //beginstate checks
  @override
  void initState() {
    super.initState();
  }

  //build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("City Influencers")),
        ),
        body: const RegisterForm());
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  List<Location> _locations = [];
  String _username = '';
  String _voornaam = '';
  String _naam = '';
  String _wachtwoord = '';
  Location? _location;
  String _geboortedatum = '';
  String _email = '';


  @override
  void initState() {
    super.initState();
    _getLocations();
  }

  void _getLocations() async {
    await CityInfluencerApi.fetchLocations().then((result) {
      setState(() {
        _locations = result.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Add TextFormFields and ElevatedButton here.
              const Text("Voornaam:"),
              TextFormField(
                decoration: const InputDecoration(hintText: "Voornaam..."),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Geef een voornaam in';
                  }
                  return null;
                },
                onChanged: (String string) {
                  _voornaam = string;
                },
              ),
              const Text("Naam:"),
              TextFormField(
                decoration: const InputDecoration(hintText: "Naam..."),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Geef een naam in';
                  }
                  return null;
                },
                onChanged: (String string) {
                  _naam = string;
                },
              ),
              const Text("Gebruikersnaam:"),
              TextFormField(
                decoration:
                    const InputDecoration(hintText: "Gebruikersnaam..."),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Geef een gebruikersnaam in';
                  }
                  return null;
                },
                onChanged: (String string) {
                  _username = string;
                },
              ),

              const Text("Wachtwoord:"),
              TextFormField(
                decoration: const InputDecoration(hintText: "Wachtwoord..."),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Geef een wachtwoord in';
                  }
                  return null;
                },
                onChanged: (String string) {
                  _wachtwoord = string;
                },
                obscureText: true,
              ),
              const Text("Geboortedatum:"),
              TextFormField(
                decoration: const InputDecoration(hintText: "yyyy-MM-dd"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Geef een geboortedatum in';
                  }
                  return null;
                },
                onChanged: (String geboortedatum) {
                  _geboortedatum = geboortedatum;
                },
              ),
              const Text("Email:"),
              TextFormField(
                decoration:
                    const InputDecoration(hintText: "voorbeeld@gmail.com"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Geef een email in';
                  }
                  return null;
                },
                onChanged: (String string) {
                  _email = string;
                },
              ),
              const Text("Locatie: "),
              LocationDropdownButton(
                labelText: "locatie",
                selectedLocation: _location,
                locations: _locations,
                onLocationSelected: (location) {
                  _onLocationChanged(location);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      _onSubmit(
                        _username,
                        _voornaam,
                        _naam,
                        _wachtwoord,
                        _geboortedatum,
                        _email,
                        _location!,
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ));
  }

  void _onLocationChanged(Location location) {
    setState(() {
      _location = location;
    });
  }

  void _onSubmit(
    String username,
    String voornaam,
    String naam,
    String wachtwoord,
    String geboortedatum,
    String email,
    Location locatie,
  ) async {
    User user = User(
      userId: 0,
      userName: username,
      firstName: voornaam,
      name: naam,
      password: wachtwoord,
      birthDate: geboortedatum + "T22:00:00.000+00:00",
      email: email,
      location: locatie,
    );
    await CityInfluencerApi.createUser(user);
    user = await CityInfluencerApi.getUser(user.userName);
    _navigateToRegister2(user);
  }

  void _navigateToRegister2(User user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  RegisterInfluencerPage( user: user)),
    );
  }
}
