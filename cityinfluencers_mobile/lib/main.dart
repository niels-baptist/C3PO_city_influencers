import 'package:cityinfluencers_mobile/pages/home.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(const MyApp());
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  static const String _title = 'City Influencers';
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Center( child: Text(_title))),
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
 
  @override
  void initState() {
    super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
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
                //input e-mail
            Container(
              padding: const EdgeInsets.all(10),
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail adres',
                ),
              ),
            ),
            //input wachtwoord
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Wachtwoord',
                ),
              ),
            ),
            //knop wachtwoord vergeten
            Padding(padding: const EdgeInsets.all(5.0), child:
            TextButton(
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
                    _navigateToHome(1);
                  },
                )
            ),
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
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  } 
  //geef door naar home page
  void _navigateToHome(int id) async {
    await Navigator.push(
      context,
     MaterialPageRoute(
          builder: (context) => HomePage(id: id)),
    );
  }
}