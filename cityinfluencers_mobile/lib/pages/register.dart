import 'package:cityinfluencers_mobile/apis/cityinfluencer_api.dart';
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

// Define a corresponding State class.
// This class holds data related to the form.
class RegisterFormState extends State<RegisterForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String _voornaam = '';
  String _naam = '';
  String _wachtwoord = '';
  String _adres = '';
  String _geboortedatum = '';
  late String _geslacht;
  String _email = '';

  final _geslachten = [
      'M', 'V', 'X'
  ];

 @override
  void initState() {
    super.initState();
    _geslacht = _geslachten[0];
  }
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(5.0), 
    child:   
      Form(
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
                const Text("Adres:"),
            TextFormField(
              decoration: const InputDecoration(hintText: "Adres..."),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Geef een adres in';
                }
                return null;
                },
                onChanged: (String string) {
                  _adres = string;
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
            ),
                const Text("Geboortedatum:"),
            TextFormField(
              decoration: const InputDecoration(hintText: "dd/MM/yyyy"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Geef een geboortedatum in';
                }
                return null;
                },
                onChanged: (String string) {
                  _geboortedatum = string;
                },
            ),
                const Text("Email:"),
            TextFormField(
              decoration: const InputDecoration(hintText: "voorbeeld@gmail.com"),
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
            const Text("Geslacht: "),
            GenderDropdownButton(
              labelText: "geslacht",
              selectedGender: _geslacht,
              genders: _geslachten,
              onGenderSelected: (gender) {
                _onGenderChanged(gender);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    _onSubmit(_voornaam, _naam, _adres, _wachtwoord, _geboortedatum, _email, _geslacht);
                    
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      )
    );
   
  }

  void _onGenderChanged(String geslacht) {
    setState(() {
      _geslacht = geslacht;
    });
  }

  void _onSubmit(String voornaam, String naam, String adres, String wachtwoord, String geboortedatum, String email, String geslacht){
    
    User user = User(id: 2, firstName: voornaam, name: naam, adress: adres, password: wachtwoord, birthDate: geboortedatum, email: email, gender: geslacht);
    CityInfluencerApi.createUser(user);
    _navigateToMain();
  }

  void _navigateToMain() async {
    await Navigator.push(
      context,
     MaterialPageRoute(
          builder: (context) => const MyApp()),
    );
  }
}
    