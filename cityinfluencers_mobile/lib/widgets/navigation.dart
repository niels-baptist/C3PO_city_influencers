import 'package:cityinfluencers_mobile/main.dart';
import 'package:cityinfluencers_mobile/models/influencer.dart';
import 'package:cityinfluencers_mobile/models/user.dart';
import 'package:cityinfluencers_mobile/pages/campaigns.dart';
import 'package:cityinfluencers_mobile/pages/home.dart';
import 'package:cityinfluencers_mobile/pages/profile.dart';
import 'package:cityinfluencers_mobile/pages/vouchers.dart';
import 'package:flutter/material.dart';

class NavigationWidget extends StatelessWidget {
  final Influencer? influencer;
  const NavigationWidget({Key? key, required this.influencer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
      child:
      Drawer(
        child: ListView(
          children: <Widget>[
            //navigatie user paneeltje
            UserAccountsDrawerHeader(
              
              accountName: Text(
                  influencer!.user.firstName + " " + influencer!.user.name,
                  style: const TextStyle(color: Colors.white)),
              accountEmail: Text(influencer!.user.email,
                  style: const TextStyle(color: Colors.white)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  influencer!.user.firstName.substring(0, 1),
                  style: const TextStyle(
                    fontSize: 40.0,
                  ),
                ),
              ),
            ),
            //navigate to home
              ListTile(
                title:
                    const Text('Home'),
                trailing: const Icon(Icons.house_outlined),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          HomePage(username: influencer!.user.userName)));
                },
              ),
            //navigate to profile
              ListTile(
                title: const Text('Mijn Profiel'),
                trailing:
                    const Icon(Icons.person_outlined),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProfilePage(username: influencer!.user.userName)));
                },
              ),
              //navigate to vouchers
                  ListTile(
                title: const Text('Vouchers'),
                trailing: const Icon(Icons.money_outlined),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          VoucherPage(username: influencer!.user.userName)));
                },
              ),
            ListTile(
              title: const Text('Uitloggen'),
              trailing: const Icon(Icons.logout_outlined),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const MyApp()));
              },
            ),
          ],
        ),
    ));
  }
}
