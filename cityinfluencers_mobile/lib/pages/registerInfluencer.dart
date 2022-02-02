// ignore: file_names
// ignore_for_file: file_names

import 'package:cityinfluencers_mobile/apis/cityinfluencer_api.dart';
import 'package:cityinfluencers_mobile/models/domain.dart';
import 'package:cityinfluencers_mobile/models/influencer.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import '../models/user.dart';
import '../main.dart';
import '../widgets/genderdropdownbutton.dart';

class RegisterInfluencerPage extends StatefulWidget {
  const RegisterInfluencerPage({Key? key, 
  required this.user})
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
            centerTitle: true,
            automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          title:  
            Align(alignment: Alignment.topRight,
                  child: Image.asset("assets/ci-logo.png", fit: BoxFit.cover, height: 100),
            ),
        ),
        body: RegisterForm(user: widget.user
        ));
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key, required this.user} ) : super(key: key);
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
              Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Registreer je',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              )),
              Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.10, 
                  right: MediaQuery.of(context).size.width * 0.10),
                child:
                  GenderDropdownButton(
                    labelText: "geslacht",
                    selectedGender: _geslacht,
                    genders: _geslachten,
                    onGenderSelected: (geslacht) {
                      _onGenderChanged(geslacht);
                    },
                  )
              ),
              Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.10, 
                  right: MediaQuery.of(context).size.width * 0.10, 
                  bottom: MediaQuery.of(context).size.height * 0.05),
                child:
                  MultiSelectFormField(
                    chipBackGroundColor: Colors.cyan,
                    chipLabelStyle: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    dialogTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                    checkBoxActiveColor: Colors.cyan,
                    checkBoxCheckColor: Colors.cyanAccent,
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
                  )
              ),
             SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                  style: 
                          ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          onPrimary: Colors.white
                          ),
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
