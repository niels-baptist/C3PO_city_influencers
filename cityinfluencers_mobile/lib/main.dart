import 'package:cityinfluencers_mobile/apis/cityinfluencer_api.dart';
import 'package:cityinfluencers_mobile/models/user.dart';
import 'package:cityinfluencers_mobile/pages/home.dart';
import 'package:cityinfluencers_mobile/pages/register.dart';
import 'package:cityinfluencers_mobile/pages/registerInfluencer.dart';
import 'package:flutter/material.dart';
import 'models/influencer.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'City Influencers';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Center(child: Text(_title))),
        body: const LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = '';
  String _password = '';
  Influencer? influencer;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // verwijder de controllers na gebruik widget.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          //kop
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Welkom bij City Influencers',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Sign in',
                style: TextStyle(fontSize: 20),
              )),

          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Gebruikersnaam',
              ),
            ),
          ),
          //input wachtwoord
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Wachtwoord',
              ),
            ),
          ),
          //knop wachtwoord vergeten
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text('Wachtwoord vergeten?'),
              )),
          //login knop
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  _username = usernameController.text;
                  _password = passwordController.text;
                  _onLogin(_username, _password);
                },
              )),
          //register knop
          Row(
            children: <Widget>[
              const Text("Nog geen account?"),
              TextButton(
                child: const Text(
                  'Registeer je',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  _navigateToRegister();
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }

  //check login gegevens en ga verder naar home
  void _onLogin(String username, String password) async {
    await CityInfluencerApi.auth(username, password).then((result) {
      influencer = result;
    });
    _navigateToHome(influencer!.user.userName);
  }

  //naar home pagina
  void _navigateToHome(String? userName) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage(username: userName)),
    );
  }

  //naar registratie pagina
  void _navigateToRegister() async {
    await Navigator.push(
      context,
       MaterialPageRoute(builder: (context) => const RegisterPage()),

    );
  }
}
