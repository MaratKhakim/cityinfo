import 'package:flutter/material.dart';

import '../utils/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  static const routName = '/profile_page';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('PROFILE')),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        //padding: EdgeInsets.symmetric(vertical: 16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20,),
                  child: CircleAvatar(
                    radius: 60,
                  ),
                ),
                //SizedBox(height: 10),
                Text('+998 99 1234567'),
                SizedBox(height: 40),
                Form(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).translate('NAME'),
                            labelText: AppLocalizations.of(context).translate('NAME'),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          onSaved: (val) {},
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).translate('SURNAME'),
                            labelText: AppLocalizations.of(context).translate('SURNAME'),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          onSaved: (val) {},
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                RaisedButton(
                  child: Text(
                    AppLocalizations.of(context).translate('SAVE'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
