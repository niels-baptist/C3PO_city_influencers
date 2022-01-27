// ignore: file_names
// ignore_for_file: file_names

import 'package:cityinfluencers_mobile/apis/cityinfluencer_api.dart';
import 'package:cityinfluencers_mobile/models/domain.dart';
import 'package:cityinfluencers_mobile/models/influencer.dart';
import 'package:cityinfluencers_mobile/models/location.dart';
import 'package:cityinfluencers_mobile/widgets/domaindropdownbutton.dart';
import 'package:cityinfluencers_mobile/widgets/locationdropdownbutton.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import '../models/user.dart';
import '../main.dart';
import '../widgets/genderdropdownbutton.dart';

class RegisterInfluencerPage extends StatefulWidget {
  const RegisterInfluencerPage({Key? key, required this.user})
      : super(key: key);
  final User user;

  @override
  State<StatefulWidget> createState() => _RegisterInfluencerPageState();
}

class _RegisterInfluencerPageState extends State<RegisterInfluencerPage> {
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
        body: RegisterForm(user: widget.user));
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String? _geslacht;
  List<Domain> _domains = [];
  List<Domain> _selectedDomains = [];

  final _geslachten = ['M', 'V', 'X'];

  @override
  void initState() {
    super.initState();
    _getDomains();
  }

  void _getDomains() async {
    await CityInfluencerApi.fetchDomains().then((result) {
      setState(() {
        _domains = result.toList();
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
              const Text("Geslacht: "),
              GenderDropdownButton(
                labelText: "geslacht",
                selectedGender: _geslacht,
                genders: _geslachten,
                onGenderSelected: (geslacht) {
                  _onGenderChanged(geslacht);
                },
              ),
              MultiSelectFormField(
                chipBackGroundColor: Colors.deepPurple,
                chipLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
                dialogTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                checkBoxActiveColor: Colors.deepPurple,
                checkBoxCheckColor: Colors.deepPurpleAccent,
                dialogShapeBorder: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
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
                  if (value == null) return;
                  setState(() {
                    for (Domain domain in value) {
                      _selectedDomains.add(domain);
                    }
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      _onSubmit(
                        _geslacht!,
                        _selectedDomains,
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

  void _onGenderChanged(String geslacht) {
    setState(() {
      _geslacht = geslacht;
    });
  }

  void _onSubmit(String geslacht, List<Domain> domains) async {
    Influencer influencer =
        Influencer(gender: geslacht, user: widget.user, domains: domains);
    await CityInfluencerApi.createInfluencer(influencer);
    _navigateToMain();
  }

  void _navigateToMain() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()),
    );
  }
}
