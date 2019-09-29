import 'package:flutter/material.dart';

import '../screen/profile_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    child: Icon(
                      Icons.face,
                      size: 60,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('+998 99 1234567')
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(ProfileScreen.routName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.rate_review),
            title: Text('Rate us!'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.label),
            title: Text('About us'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
