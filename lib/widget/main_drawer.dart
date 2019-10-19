import 'dart:convert';

import 'package:flutter/material.dart';

import '../screen/profile_screen.dart';
import '../utils/app_localizations.dart';
import '../utils/sharedprefs_helper.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final jsonUser = SharedPrefsHelper.getString('user');
    final String phoneNumber = json.decode(jsonUser)['phoneNumber'];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/enterance_logo.png'),
                  SizedBox(height: 16),
                  Text(
                    phoneNumber,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          /*ListTile(
            leading: Icon(Icons.settings),
            title: Text(AppLocalizations.of(context).translate('SETTINGS')),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(ProfileScreen.routName);
            },
          ),
          Divider(),*/
          ListTile(
            leading: Icon(Icons.rate_review),
            title: Text(AppLocalizations.of(context).translate('RATE_US')),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.label),
            title: Text(AppLocalizations.of(context).translate('ABOUT_US')),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
