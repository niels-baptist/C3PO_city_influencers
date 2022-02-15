import 'package:cityinfluencers_mobile/apis/cityinfluencer_api.dart';
import 'package:cityinfluencers_mobile/models/influencer.dart';
import 'package:cityinfluencers_mobile/models/location.dart';
import 'package:cityinfluencers_mobile/pages/registerInfluencer.dart';
import 'package:cityinfluencers_mobile/widgets/locationdropdownbutton.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
  DateTime selectedDate = DateTime.now();
  Location? _location;
  String _geboortedatum = '';
  String _email = '';
  var dateValue = TextEditingController();

  //beginstate checks
  @override
  void initState() {
    super.initState();
    _getLocations();
  }
  //haal locaties af
  void _getLocations() async {
    await CityInfluencerApi.fetchLocations().then((result) {
      setState(() {
        _locations = result.toList();
      });
    });
  }

  //build
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  // TextformFields en Buttons hier
                  // Titel.
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
                  //Voornaam ingeven
                  Container(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.10,
                      right: MediaQuery.of(context).size.width * 0.10,
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Voornaam',
                      ),
                      onChanged: (String string) {
                        _voornaam = string;
                      },
                    ),
                  ),
                  //Achternaam ingeven
                  Container(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.10,
                      right: MediaQuery.of(context).size.width * 0.10,
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Naam',
                      ),
                      onChanged: (String string) {
                        _naam = string;
                      },
                    ),
                  ),
                  //Gebruikersnaam ingeven
                  Container(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.10,
                      right: MediaQuery.of(context).size.width * 0.10,
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Gebruikersnaam',
                      ),
                      onChanged: (String string) {
                        _username = string;
                      },
                    ),
                  ),
                  //wachtwoord ingeven
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
                        _wachtwoord = string;
                      },
                      obscureText: true,
                    ),
                  ),
                  //Email ingeven
                  Container(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.10,
                      right: MediaQuery.of(context).size.width * 0.10,
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                      ),
                      onChanged: (String string) {
                        _email = string;
                      },
                    ),
                  ),
                  //Geboortedatum ingeven
                  Container(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.10,
                      right: MediaQuery.of(context).size.width * 0.10,
                    ),
                    child: GestureDetector(
                      child: TextFormField(
                        controller: dateValue,
                        onTap: () {
                          _selectDate();
                          dateValue.text =
                              "${selectedDate.toLocal()}".split(' ')[0];
                        },
                        decoration: const InputDecoration(
                          labelText: "Geboortedatum",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //locatie ingeven
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
                  const Divider(),
                  //Knop naar volgende deel
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          style: TextButton.styleFrom(primary: Colors.black),
                          onPressed: () {
                            // Form validatie.
                            if (_formKey.currentState!.validate()) {
                              _onSubmit(
                                _username,
                                _voornaam,
                                _naam,
                                _wachtwoord,
                                selectedDate,
                                _email,
                                _location!,
                              );
                            }
                          },
                          child: const Icon(Icons.arrow_forward),
                        ),
                      )),
                ],
              ),
            )));
  }

  //veranderen van locatie
  void _onLocationChanged(Location location) {
    setState(() {
      _location = location;
    });
  }

  //submitten van ingegeven data om een basic user aan te maken + doorgeven aan deel 2
  void _onSubmit(
    String username,
    String voornaam,
    String naam,
    String wachtwoord,
    DateTime selectedDate,
    String email,
    Location locatie,
  ) async {
    User user = User(
      userId: 0,
      userName: username,
      firstName: voornaam,
      name: naam,
      password: wachtwoord,
      birthDate:
          DateFormat('yyyy-MM-dd').format(selectedDate) + "T22:00:00.000+00:00",
      email: email,
      location: locatie,
    );
    user = await CityInfluencerApi.createUser(user);
    _navigateToRegister2(user);
  }

  //Datepicker oproepen
  void _selectDate() {
    showRoundedDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.year,
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
        theme: ThemeData(primaryColor: Colors.cyan[300]),
        styleDatePicker: MaterialRoundedDatePickerStyle(
          textStyleDayButton:
              const TextStyle(fontSize: 36, color: Colors.black),
          textStyleYearButton: const TextStyle(
            fontSize: 26,
            color: Colors.black,
          ),
          textStyleDayHeader: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
          textStyleCurrentDayOnCalendar: const TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          textStyleDayOnCalendar:
              const TextStyle(fontSize: 14, color: Colors.black),
          textStyleDayOnCalendarSelected: const TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          textStyleDayOnCalendarDisabled:
              TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.1)),
          textStyleMonthYearHeader: const TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          paddingDatePicker: const EdgeInsets.all(0),
          paddingMonthHeader: const EdgeInsets.all(32),
          paddingActionBar: const EdgeInsets.all(16),
          paddingDateYearHeader: const EdgeInsets.all(32),
          sizeArrow: 25,
          colorArrowNext: Colors.black,
          colorArrowPrevious: Colors.black,
          marginLeftArrowPrevious: 16,
          marginTopArrowPrevious: 16,
          marginTopArrowNext: 16,
          marginRightArrowNext: 32,
          textStyleButtonAction:
              const TextStyle(fontSize: 14, color: Colors.black),
          textStyleButtonPositive: const TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          textStyleButtonNegative:
              TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5)),
          decorationDateSelected:
              BoxDecoration(color: Colors.cyan[150], shape: BoxShape.circle),
          backgroundPicker: Colors.white,
          backgroundActionBar: Colors.cyan[200],
          backgroundHeaderMonth: Colors.cyan[200],
        ),
        styleYearPicker: MaterialRoundedYearPickerStyle(
          textStyleYear: const TextStyle(fontSize: 20, color: Colors.black),
          textStyleYearSelected: const TextStyle(
              fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
          heightYearRow: 100,
          backgroundPicker: Colors.white,
        )).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        selectedDate = pickedDate;
        dateValue.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    });
  }

  //Navigation call naar deel 2
  void _navigateToRegister2(User user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RegisterInfluencerPage(user: user)),
    );
  }
}
