import 'package:cityinfluencers_mobile/apis/cityinfluencer_api.dart';
import 'package:cityinfluencers_mobile/models/user.dart';
import 'package:cityinfluencers_mobile/pages/home.dart';
import 'package:cityinfluencers_mobile/pages/register.dart';
import 'package:cityinfluencers_mobile/pages/registerInfluencer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'models/influencer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'City Influencers';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
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
    return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              //kop
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.3,
                padding: const EdgeInsets.all(10),
                child: Image.asset('assets/ci-logo.png'),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Welkom bij City Influencers',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
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
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.10,
                  right: MediaQuery.of(context).size.width * 0.10,
                ),
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Gebruikersnaam',
                  ),
                ),
              ),
              //input wachtwoord
              Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.10,
                  right: MediaQuery.of(context).size.width * 0.10,
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Wachtwoord',
                  ),
                ),
              ),
              //knop wachtwoord vergeten
              Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 50.00),
                  child: TextButton(
                    onPressed: () {
                      //forgot password screen
                    },
                    child: const Text('Wachtwoord vergeten?'),
                  )),
              //login knop
              SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPrimary: Colors.white),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _username = usernameController.text;
                      _password = passwordController.text;
                      _onLogin(_username, _password);
                    },
                  )),
              //register knop
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    const Text("Nog geen account?"),
                    TextButton(
                      child: const Text(
                        'Registeer je',
                      ),
                      onPressed: () {
                        _navigateToRegister();
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ],
          ),
        ));
  }

  //check login gegevens en ga verder naar home
  void _onLogin(String username, String password) async {
    await CityInfluencerApi.auth(username, password).then((result) {
      influencer = result;
    });
    _navigateToHome(influencer!.influencerId, influencer!.user.userName);
  }

  //naar home pagina
  void _navigateToHome(int? influencerId, String? userName) async {
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
