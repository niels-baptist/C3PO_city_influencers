import 'package:cityinfluencers_mobile/models/user.dart';
import 'package:cityinfluencers_mobile/pages/campaigns.dart';
import 'package:cityinfluencers_mobile/pages/home.dart';
import 'package:cityinfluencers_mobile/pages/profile.dart';
import 'package:cityinfluencers_mobile/pages/vouchers.dart';
import 'package:flutter/material.dart';

class NavigationWidget extends StatelessWidget {
  final User? user;
  const NavigationWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          //navigatie user paneeltje
          UserAccountsDrawerHeader(
            accountName: Text(user!.firstName + " " + user!.name),
            accountEmail: Text(user!.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                user!.userName.substring(0, 1),
                style: const TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          //navigate to home
          ListTile(
            title: const Text('Home'),
            trailing: const Icon(Icons.house),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      HomePage(id: user!.id)));
            },
          ),
           //navigate to profile
          ListTile(
            title: const Text('Mijn Profiel'),
            trailing: const Icon(Icons.person),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ProfilePage(id: user!.id)));
            },
          ),
           //navigate to campaigns
          ListTile(
            title: const Text('Campagnes'),
            trailing: const Icon(Icons.calendar_today),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      CampaignPage(id: user!.id)));
            },
          ),
             //navigate to vouchers
          ListTile(
            title: const Text('Vouchers'),
            trailing: const Icon(Icons.money),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      VoucherPage(id: user!.id)));
            },
          ),
        ],
      ),
    );
  }
}
